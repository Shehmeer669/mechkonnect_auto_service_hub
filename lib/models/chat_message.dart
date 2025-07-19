enum MessageType {
  text,
  image,
  file,
  location,
  booking,
}

enum MessageStatus {
  sent,
  delivered,
  read,
  failed,
}

class ChatMessage {
  final String id;
  final String chatId; // Reference to chat/conversation
  final String senderId; // Reference to User
  final String? receiverId; // Reference to User (for direct messages)
  final MessageType type;
  final String content;
  final String? imageUrl;
  final String? fileUrl;
  final String? fileName;
  final Map<String, dynamic>? metadata; // For location, booking references, etc.
  final MessageStatus status;
  final DateTime timestamp;
  final DateTime? editedAt;
  final bool isEdited;
  final bool isDeleted;
  final String? replyToMessageId; // Reference to another ChatMessage

  ChatMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.receiverId,
    this.type = MessageType.text,
    required this.content,
    this.imageUrl,
    this.fileUrl,
    this.fileName,
    this.metadata,
    this.status = MessageStatus.sent,
    required this.timestamp,
    this.editedAt,
    this.isEdited = false,
    this.isDeleted = false,
    this.replyToMessageId,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as String,
      chatId: map['chatId'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String?,
      type: MessageType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => MessageType.text,
      ),
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String?,
      fileUrl: map['fileUrl'] as String?,
      fileName: map['fileName'] as String?,
      metadata: map['metadata'] as Map<String, dynamic>?,
      status: MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == map['status'],
        orElse: () => MessageStatus.sent,
      ),
      timestamp: DateTime.parse(map['timestamp'] as String),
      editedAt: map['editedAt'] != null
          ? DateTime.parse(map['editedAt'] as String)
          : null,
      isEdited: map['isEdited'] as bool? ?? false,
      isDeleted: map['isDeleted'] as bool? ?? false,
      replyToMessageId: map['replyToMessageId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type.toString().split('.').last,
      'content': content,
      'imageUrl': imageUrl,
      'fileUrl': fileUrl,
      'fileName': fileName,
      'metadata': metadata,
      'status': status.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'editedAt': editedAt?.toIso8601String(),
      'isEdited': isEdited,
      'isDeleted': isDeleted,
      'replyToMessageId': replyToMessageId,
    };
  }

  ChatMessage copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? receiverId,
    MessageType? type,
    String? content,
    String? imageUrl,
    String? fileUrl,
    String? fileName,
    Map<String, dynamic>? metadata,
    MessageStatus? status,
    DateTime? timestamp,
    DateTime? editedAt,
    bool? isEdited,
    bool? isDeleted,
    String? replyToMessageId,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      metadata: metadata ?? this.metadata,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      editedAt: editedAt ?? this.editedAt,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
    );
  }

  @override
  String toString() {
    return 'ChatMessage(id: $id, chatId: $chatId, senderId: $senderId, receiverId: $receiverId, type: $type, content: $content, imageUrl: $imageUrl, fileUrl: $fileUrl, fileName: $fileName, metadata: $metadata, status: $status, timestamp: $timestamp, editedAt: $editedAt, isEdited: $isEdited, isDeleted: $isDeleted, replyToMessageId: $replyToMessageId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatMessage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}