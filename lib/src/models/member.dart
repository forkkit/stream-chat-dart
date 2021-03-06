import 'package:json_annotation/json_annotation.dart';
import '../models/user.dart';

part 'member.g.dart';

/// The class that contains the information about the user membership in a channel
@JsonSerializable()
class Member {
  /// The interested user
  final User user;

  /// The date in which the user accepted the invite to the channel
  final DateTime inviteAcceptedAt;

  /// The date in which the user rejected the invite to the channel
  final DateTime inviteRejectedAt;

  /// True if the user has been invited to the channel
  final bool invited;

  /// The role of the user in the channel
  final String role;

  /// The id of the interested user
  final String userId;

  /// True if the user is a moderator of the channe;
  final bool isModerator;

  /// The date of creation
  final DateTime createdAt;

  /// The last date of update
  final DateTime updatedAt;

  /// Constructor used for json serialization
  Member({
    this.user,
    this.inviteAcceptedAt,
    this.inviteRejectedAt,
    this.invited,
    this.role,
    this.userId,
    this.isModerator,
    this.createdAt,
    this.updatedAt,
  });

  /// Create a new instance from a json
  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  /// Serialize to json
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
