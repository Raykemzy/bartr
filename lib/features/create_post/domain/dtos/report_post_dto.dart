class ReportPostDto {
  final String? userId;
  final String? postId;
  final String reason;
  ReportPostDto({
    this.userId,
    this.postId,
    required this.reason,
  });

  Map<String, dynamic> toJson() => {
        if (userId != null) 'userId': userId,
        if (postId != null) 'postId': postId,
        'reason': reason,
      };
}
