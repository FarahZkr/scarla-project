/*
 * Copyright (c) 2021. Scarla
 */

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'groups_record.g.dart';

/// Classe de la collection [GroupsRecord] dans la base de données Firebase
///
/// Contient tous les champs de la collection [GroupsRecord]
abstract class GroupsRecord
    implements Built<GroupsRecord, GroupsRecordBuilder> {
  static Serializer<GroupsRecord> get serializer => _$groupsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'g_id')
  String get gId;

  @nullable
  @BuiltValueField(wireName: 'g_name')
  String get gName;

  @nullable
  @BuiltValueField(wireName: 'g_photo_url')
  String get gPhotoUrl;

  @nullable
  @BuiltValueField(wireName: 'last_message')
  String get lastMessage;

  @nullable
  @BuiltValueField(wireName: 'last_message_timestamp')
  Timestamp get lastMessageTimestamp;

  @nullable
  @BuiltValueField(wireName: 'members_id')
  BuiltList<String> get membersId;

  @nullable
  DocumentReference get host;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GroupsRecordBuilder builder) => builder
    ..gId = ''
    ..gName = ''
    ..gPhotoUrl = ''
    ..lastMessage = ''
    ..membersId = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('groups');

  static Stream<GroupsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GroupsRecord._();

  factory GroupsRecord([void Function(GroupsRecordBuilder) updates]) =
      _$GroupsRecord;
}

Map<String, dynamic> createGroupsRecordData({
  String gId,
  String gName,
  String gPhotoUrl,
  String lastMessage,
  Timestamp lastMessageTimestamp,
  DocumentReference host,
}) =>
    serializers.serializeWith(
        GroupsRecord.serializer,
        GroupsRecord((g) => g
          ..gId = gId
          ..gName = gName
          ..gPhotoUrl = gPhotoUrl
          ..lastMessage = lastMessage
          ..lastMessageTimestamp = lastMessageTimestamp
          ..membersId = null
          ..host = host));

GroupsRecord get dummyGroupsRecord {
  final builder = GroupsRecordBuilder()
    ..gId = dummyString
    ..gName = dummyString
    ..gPhotoUrl = dummyImagePath
    ..lastMessage = dummyString
    ..lastMessageTimestamp = dummyTimestamp
    ..membersId = ListBuilder([dummyString, dummyString]);
  return builder.build();
}

List<GroupsRecord> createDummyGroupsRecord({int count}) =>
    List.generate(count, (_) => dummyGroupsRecord);
