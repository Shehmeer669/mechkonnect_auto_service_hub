import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;
  
  static SupabaseClient get client => _client;
  static User? get currentUser => _client.auth.currentUser;
  static Session? get currentSession => _client.auth.currentSession;
  
  // Authentication
  static Future<AuthResponse> signInWithOtp({
    required String email,
    String? phone,
  }) async {
    if (phone != null) {
      return await _client.auth.signInWithOtp(phone: phone);
    } else {
      return await _client.auth.signInWithOtp(email: email);
    }
  }
  
  static Future<AuthResponse> verifyOtp({
    required String token,
    required OtpType type,
    String? email,
    String? phone,
  }) async {
    return await _client.auth.verifyOTP(
      token: token,
      type: type,
      email: email,
      phone: phone,
    );
  }
  
  static Future<void> signOut() async {
    await _client.auth.signOut();
  }
  
  // User Profile
  static Future<UserModel?> getUserProfile(String userId) async {
    try {
      final response = await _client
          .from('users')
          .select()
          .eq('id', userId)
          .single();
      
      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
  
  static Future<UserModel?> createUserProfile(UserModel user) async {
    try {
      final response = await _client
          .from('users')
          .insert(user.toJson())
          .select()
          .single();
      
      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
  
  static Future<UserModel?> updateUserProfile(UserModel user) async {
    try {
      final response = await _client
          .from('users')
          .update(user.toJson())
          .eq('id', user.id)
          .select()
          .single();
      
      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }
  
  // File Upload
  static Future<String?> uploadFile({
    required String bucket,
    required String path,
    required List<int> bytes,
  }) async {
    try {
      await _client.storage.from(bucket).uploadBinary(path, bytes);
      final url = _client.storage.from(bucket).getPublicUrl(path);
      return url;
    } catch (e) {
      return null;
    }
  }
  
  static Future<bool> deleteFile({
    required String bucket,
    required String path,
  }) async {
    try {
      await _client.storage.from(bucket).remove([path]);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Realtime Subscriptions
  static RealtimeChannel subscribeToTable(
    String table,
    void Function(PostgresChangePayload) onData,
  ) {
    return _client
        .channel('$table-changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: table,
          callback: onData,
        )
        .subscribe();
  }
  
  static RealtimeChannel subscribeToChat(
    String chatRoomId,
    void Function(PostgresChangePayload) onMessage,
  ) {
    return _client
        .channel('chat-$chatRoomId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'chat_messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'chat_room_id',
            value: chatRoomId,
          ),
          callback: onMessage,
        )
        .subscribe();
  }
  
  // Generic Database Operations
  static Future<List<T>> selectAll<T>(
    String table,
    T Function(Map<String, dynamic>) fromJson, {
    String? orderBy,
    bool ascending = true,
    int? limit,
    String? filter,
  }) async {
    try {
      var query = _client.from(table).select();
      
      if (filter != null) {
        // Add filter logic here based on requirements
      }
      
      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }
      
      if (limit != null) {
        query = query.limit(limit);
      }
      
      final response = await query;
      return (response as List).map((json) => fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
  
  static Future<T?> selectSingle<T>(
    String table,
    T Function(Map<String, dynamic>) fromJson,
    String column,
    dynamic value,
  ) async {
    try {
      final response = await _client
          .from(table)
          .select()
          .eq(column, value)
          .single();
      
      return fromJson(response);
    } catch (e) {
      return null;
    }
  }
  
  static Future<T?> insert<T>(
    String table,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await _client
          .from(table)
          .insert(data)
          .select()
          .single();
      
      return fromJson(response);
    } catch (e) {
      return null;
    }
  }
  
  static Future<T?> update<T>(
    String table,
    Map<String, dynamic> data,
    String idColumn,
    String id,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await _client
          .from(table)
          .update(data)
          .eq(idColumn, id)
          .select()
          .single();
      
      return fromJson(response);
    } catch (e) {
      return null;
    }
  }
  
  static Future<bool> delete(
    String table,
    String column,
    dynamic value,
  ) async {
    try {
      await _client.from(table).delete().eq(column, value);
      return true;
    } catch (e) {
      return false;
    }
  }
}