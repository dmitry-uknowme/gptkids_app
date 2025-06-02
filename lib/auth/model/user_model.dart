//  "imei": "+79273338310",
//     "telegram_id": "string",
//     "parent_user_guid": "dima@ariel.test",
//     "user_guid": "+79273338310",
//     "subscription_total_tokens": 0,
//     "role": "ROLE_STUDENT",
//     "status": "STATUS_ACTIVE"

class UserModel {
  final String userId;
  final String parentUserId;
  final String telegramId;
  final String subscriptionTokens;

  const UserModel({
    required this.userId,
    required this.parentUserId,
    required this.telegramId,
    required this.subscriptionTokens,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['user_guid'],
    parentUserId: json['parent_user_guid'],
    telegramId: json['telegram_id'],
    subscriptionTokens: json['subscription_total_tokens'].toString(),
  );
}
