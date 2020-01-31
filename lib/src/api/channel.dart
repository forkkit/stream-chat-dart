import 'dart:convert';

import 'package:dio/dio.dart';

import '../client.dart';
import 'requests.dart';
import 'responses.dart';
import '../models/message.dart';
import '../models/event.dart';
import '../models/reaction.dart';
import '../models/member.dart';

class Channel {
  Client _client;
  String type;
  String id;
  Map<String, dynamic> data;

  Channel(this._client, this.type, this.id, this.data);

  Client get client => _client;

  String get _channelURL => "/channels/$type/$id";

  Future<SendMessageResponse> sendMessage(Message message) async {
    final response = await _client.httpClient.post<String>(
      "$_channelURL/message",
      data: {"message": message.toJson()},
    );
    return _client.decode(response.data, SendMessageResponse.fromJson);
  }

  Future<SendFileResponse> sendFile(MultipartFile file) async {
    final response = await _client.httpClient.post<String>(
      "$_channelURL/file",
      data: FormData.fromMap({'file': file}),
    );
    return _client.decode(response.data, SendFileResponse.fromJson);
  }

  Future<SendImageResponse> sendImage(MultipartFile file) async {
    final response = await _client.httpClient.post<String>(
      "$_channelURL/image",
      data: FormData.fromMap({'file': file}),
    );
    return _client.decode(response.data, SendImageResponse.fromJson);
  }

  Future<EmptyResponse> deleteFile(String url) async {
    final response = await _client.httpClient
        .delete("$_channelURL/file", queryParameters: {"url": url});
    return _client.decode(response.data, EmptyResponse.fromJson);
  }

  Future<EmptyResponse> deleteImage(String url) async {
    final response = await _client.httpClient
        .delete("$_channelURL/image", queryParameters: {"url": url});
    return _client.decode(response.data, EmptyResponse.fromJson);
  }

  Future<EmptyResponse> sendEvent(Event event) {
    return _client.httpClient.post<String>(
      "$_channelURL/event",
      data: {"event": event.toJson()},
    ).then((res) {
      return EmptyResponse.fromJson(json.decode(res.data.toString()));
    });
  }

  Future<SendReactionResponse> sendReaction(
    String messageID,
    Reaction reaction,
  ) async {
    final res = await _client.httpClient.post<String>(
      "/messages/$messageID/reaction",
      data: {"reaction": reaction.toJson()},
    );
    return _client.decode(res.data, SendReactionResponse.fromJson);
  }

  Future<EmptyResponse> deleteReaction(String messageID, String reactionType) {
    return client.httpClient
        .delete("${client.baseURL}/messages/$messageID/reaction/$reactionType")
        .then((value) =>
            EmptyResponse.fromJson(json.decode(value.data.toString())));
  }

  Future<UpdateChannelResponse> update(
    Map<String, dynamic> channelData,
    Message updateMessage,
  ) async {
    final response = await _client.httpClient.post<String>(_channelURL);
    return _client.decode(response.data, UpdateChannelResponse.fromJson);
  }

  Future<EmptyResponse> delete() async {
    final response = await _client.httpClient.delete<String>(_channelURL);
    return _client.decode(response.data, EmptyResponse.fromJson);
  }

  Future<EmptyResponse> truncate() async {
    final response =
        await _client.httpClient.post<String>("$_channelURL/truncate");
    return _client.decode(response.data, EmptyResponse.fromJson);
  }

  Future<AcceptInviteResponse> acceptInvite([Message message = null]) async {
    final res = await _client.httpClient.post<String>(_channelURL,
        data: {"accept_invite": true, "message": message?.toJson()});
    return _client.decode(res.data, AcceptInviteResponse.fromJson);
  }

  Future<RejectInviteResponse> rejectInvite([Message message = null]) async {
    final res = await _client.httpClient.post<String>(_channelURL,
        data: {"accept_invite": false, "message": message?.toJson()});
    return _client.decode(res.data, RejectInviteResponse.fromJson);
  }

  Future<AddMembersResponse> addMembers(
      List<Member> members, Message message) async {
    final res = await _client.httpClient.post<String>(_channelURL, data: {
      "add_members": members.map((m) => m.toJson()),
      "message": message.toJson(),
    });
    return _client.decode(res.data, AddMembersResponse.fromJson);
  }

  Future<AddModeratorsResponse> addModerators(
    List<Member> moderators,
    Message message,
  ) async {
    final res = await _client.httpClient.post<String>(_channelURL, data: {
      "add_moderators": moderators.map((m) => m.toJson()),
      "message": message.toJson(),
    });
    return _client.decode(res.data, AddModeratorsResponse.fromJson);
  }

  Future<InviteMembersResponse> inviteMembers(
    List<Member> members,
    Message message,
  ) async {
    final res = await _client.httpClient.post<String>(_channelURL, data: {
      "invites": members.map((m) => m.toJson()),
      "message": message.toJson(),
    });
    return _client.decode(res.data, InviteMembersResponse.fromJson);
  }

  Future<RemoveMembersResponse> removeMembers(
      List<Member> members, Message message) async {
    final res = await _client.httpClient.post<String>(_channelURL, data: {
      "remove_members": members.map((m) => m.toJson()),
      "message": message.toJson(),
    });
    return _client.decode(res.data, RemoveMembersResponse.fromJson);
  }

  Future<DemoteModeratorsResponse> demoteModerators(
      List<Member> members, Message message) async {
    final res = await _client.httpClient.post<String>(_channelURL, data: {
      "demote_moderators": members.map((m) => m.toJson()),
      "message": message.toJson(),
    });
    return _client.decode(res.data, DemoteModeratorsResponse.fromJson);
  }

  Future<SendActionResponse> sendAction(
      String messageID, Map<String, dynamic> formData) async {
    final response = await _client.httpClient.post<String>(
        "/messages/$messageID/action",
        data: {'id': id, 'type': type, 'form_data': formData});
    return _client.decode(response.data, SendActionResponse.fromJson);
  }

  Future<EmptyResponse> markRead() async {
    final response = await _client.httpClient.post<String>("$_channelURL/read");
    return _client.decode(response.data, EmptyResponse.fromJson);
  }

  // TODO watch
  Future<EmptyResponse> watch(dynamic options) async => null;

  Future<EmptyResponse> stopWatching() async {
    final response =
        await _client.httpClient.post<String>("$_channelURL/stop-watching");
    return _client.decode(response.data, EmptyResponse.fromJson);
  }

  Future<QueryRepliesResponse> getReplies(
      String parentID, PaginationParams options) async {
    final response = await _client.httpClient.get<String>(
        "/messages/$parentID/replies",
        queryParameters: options.toJson());
    return _client.decode<QueryRepliesResponse>(
        response.data, QueryRepliesResponse.fromJson);
  }

  Future<QueryReactionsResponse> getReactions(
      String messageID, PaginationParams options) async {
    final response = await _client.httpClient.get<String>(
      "/messages/$messageID/reactions",
      queryParameters: options.toJson(),
    );
    return _client.decode<QueryReactionsResponse>(
        response.data, QueryReactionsResponse.fromJson);
  }

  Future<GetMessagesByIdResponse> getMessagesById(
      List<String> messageIDs) async {
    final response = await _client.httpClient.get<String>(
      "$_channelURL/messages",
      queryParameters: {'ids': messageIDs.join(',')},
    );
    return _client.decode<GetMessagesByIdResponse>(
        response.data, GetMessagesByIdResponse.fromJson);
  }

  // TODO create
  Future<EmptyResponse> create() async => null;

  // TODO query
  Future<EmptyResponse> query(dynamic options) async => null;

  Future<EmptyResponse> banUser(
    String userID,
    Map<String, dynamic> options,
  ) async {
    final opts = Map.from(options)
      ..addAll({
        'type': type,
        'id': id,
      });
    return _client.banUser(userID, opts);
  }

  Future<EmptyResponse> unbanUser(String userID) async {
    return _client.unbanUser(userID, {
      'type': type,
      'id': id,
    });
  }

  Future<EmptyResponse> hide([bool clearHistory = false]) async {
    final response = await _client.httpClient.post<String>("$_channelURL/hide",
        data: {'clear_history': clearHistory});
    return _client.decode(response.data, EmptyResponse.fromJson);
  }

  Future<EmptyResponse> show() async {
    final response = await _client.httpClient.post<String>("$_channelURL/show");
    return _client.decode(response.data, EmptyResponse.fromJson);
  }

  Stream<Event> on(String eventType) => null;
}
