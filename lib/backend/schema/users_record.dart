/*
 * Copyright (c) 2021. Scarla
 */

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'users_record.g.dart';

/// Classe de la collection [UsersRecord] dans la base de données Firebase
///
/// Contient tous les champs de la collection [UsersRecord]
abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get about;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get bgProfile;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'TAG')
  String get tag;

  @nullable
  bool get isCompetitive;

  @nullable
  bool get isToxic;

  @nullable
  DocumentReference get ranksRef;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  Timestamp get createdTime;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'selected_games')
  BuiltList<String> get selectedGames;

  @nullable
  BuiltList<String> get keys;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..about = ''
    ..name = ''
    ..photoUrl = ''
    ..bgProfile = ''
    ..email = ''
    ..displayName = ''
    ..tag = ''
    ..isCompetitive = false
    ..isToxic = false
    ..uid = ''
    ..selectedGames = ListBuilder()
    ..keys = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();

  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;
}

Map<String, dynamic> createUsersRecordData({
  String about,
  String name,
  String photoUrl,
  String bgProfile,
  String email,
  String displayName,
  String tag,
  bool isCompetitive,
  bool isToxic,
  DocumentReference ranksRef,
  Timestamp createdTime,
  String uid,
}) =>
    serializers.serializeWith(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..about = about
          ..name = name
          ..photoUrl = photoUrl
          ..bgProfile = bgProfile
          ..email = email
          ..displayName = displayName
          ..tag = tag
          ..isCompetitive = isCompetitive
          ..isToxic = isToxic
          ..ranksRef = ranksRef
          ..createdTime = createdTime
          ..uid = uid
          ..selectedGames = null
          ..keys = null));

UsersRecord get dummyUsersRecord {
  final builder = UsersRecordBuilder()
    ..about = dummyString
    ..name = dummyString
    ..photoUrl = dummyImagePath
    ..bgProfile = dummyImagePath
    ..email = dummyString
    ..displayName = dummyString
    ..tag = dummyString
    ..isCompetitive = dummyBoolean
    ..isToxic = dummyBoolean
    ..createdTime = dummyTimestamp
    ..uid = dummyString
    ..selectedGames = ListBuilder([dummyString, dummyString])
    ..keys = ListBuilder([dummyString, dummyString]);
  return builder.build();
}

List<UsersRecord> createDummyUsersRecord({int count}) =>
    List.generate(count, (_) => dummyUsersRecord);
