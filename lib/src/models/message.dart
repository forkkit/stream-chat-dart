import 'package:json_annotation/json_annotation.dart';

import 'attachment.dart';
import 'reaction.dart';
import 'serialization.dart';
import 'user.dart';

part 'message.g.dart';

enum MessageSendingStatus {
  SENDING,
  SENT,
  FAILED,
}

/// The class that contains the information about a message
@JsonSerializable()
class Message {
  /// The message ID. This is either created by Stream or set client side when the message is added.
  final String id;

  /// The text of this message
  final String text;

  /// The status of a sending message
  final MessageSendingStatus status;

  /// The message type
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final String type;

  /// The list of attachments, either provided by the user or generated from a command or as a result of URL scraping.
  @JsonKey(includeIfNull: false)
  final List<Attachment> attachments;

  /// The list of user mentioned in the message
  @JsonKey(toJson: Serialization.userIds)
  final List<User> mentionedUsers;

  /// A map describing the count of number of every reaction
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final Map<String, int> reactionCounts;

  /// A map describing the count of score of every reaction
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final Map<String, int> reactionScores;

  /// The latest reactions to the message created by any user.
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final List<Reaction> latestReactions;

  /// The reactions added to the message by the current user.
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final List<Reaction> ownReactions;

  /// The ID of the parent message, if the message is a reply.
  final String parentId;

  /// Reserved field indicating the number of replies for this message.
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final int replyCount;

  /// Check if this message needs to show in the channel.
  final bool showInChannel;

  /// A used command name.
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final String command;

  /// Reserved field indicating when the message was created.
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final DateTime createdAt;

  /// Reserved field indicating when the message was updated last time.
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final DateTime updatedAt;

  /// User who sent the message
  @JsonKey(includeIfNull: false, toJson: Serialization.readOnly)
  final User user;

  /// Message custom extraData
  @JsonKey(includeIfNull: false)
  final Map<String, dynamic> extraData;

  /// Known top level fields.
  /// Useful for [Serialization] methods.
  static const topLevelFields = [
    'id',
    'text',
    'type',
    'attachments',
    'latest_reactions',
    'own_reactions',
    'mentioned_users',
    'reaction_counts',
    'reaction_scores',
    'parent_id',
    'reply_count',
    'show_in_channel',
    'command',
    'created_at',
    'updated_at',
    'user',
  ];

  /// Constructor used for json serialization
  Message({
    this.id,
    this.text,
    this.type,
    this.attachments,
    this.mentionedUsers,
    this.reactionCounts,
    this.reactionScores,
    this.latestReactions,
    this.ownReactions,
    this.parentId,
    this.replyCount = 0,
    this.showInChannel,
    this.command,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.extraData,
    this.status = MessageSendingStatus.SENT,
  });

  /// Create a new instance from a json
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(Serialization.moveKeysToRoot(json, topLevelFields));

  /// Serialize to json
  Map<String, dynamic> toJson() =>
      Serialization.moveKeysToMapInPlace(_$MessageToJson(this), topLevelFields);

  /// Creates a copy of [Message] with specified attributes overridden.
  Message copyWith({
    String id,
    String text,
    String type,
    List<Attachment> attachments,
    List<User> mentionedUsers,
    Map<String, int> reactionCounts,
    Map<String, int> reactionScores,
    List<Reaction> latestReactions,
    List<Reaction> ownReactions,
    String parentId,
    int replyCount,
    bool showInChannel,
    String command,
    DateTime createdAt,
    DateTime updatedAt,
    User user,
    Map<String, dynamic> extraData,
    MessageSendingStatus status,
  }) =>
      Message(
        id: id ?? this.id,
        text: text ?? this.text,
        type: type ?? this.type,
        attachments: attachments ?? this.attachments,
        mentionedUsers: mentionedUsers ?? this.mentionedUsers,
        reactionCounts: reactionCounts ?? this.reactionCounts,
        reactionScores: reactionScores ?? this.reactionScores,
        latestReactions: latestReactions ?? this.latestReactions,
        ownReactions: ownReactions ?? this.ownReactions,
        parentId: parentId ?? this.parentId,
        replyCount: replyCount ?? this.replyCount,
        showInChannel: showInChannel ?? this.showInChannel,
        command: command ?? this.command,
        createdAt: createdAt ?? this.createdAt,
        extraData: extraData ?? this.extraData,
        user: user ?? this.user,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
      );
}
