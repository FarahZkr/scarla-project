/*
 * Copyright (c) 2021. Scarla
 */

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'friends_record.g.dart';

/// Classe de la collection [FriendsRecord] dans la base de données Firebase
///
/// Contient tous les champs de la collection [FriendsRecord]
abstract class FriendsRecord
    implements Built<FriendsRecord, FriendsRecordBuilder> {
  static Serializer<FriendsRecord> get serializer => _$friendsRecordSerializer;

  @nullable
  String get id;

  @nullable
  int get status;

  @nullable
  BuiltList<DocumentReference> get friends;

  @nullable
  Timestamp get timestamp;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FriendsRecordBuilder builder) => builder
    ..id = ''
    ..status = 0
    ..friends = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('friends');

  static Stream<FriendsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FriendsRecord._();

  factory FriendsRecord([void Function(FriendsRecordBuilder) updates]) =
      _$FriendsRecord;
}

Map<String, dynamic> createFriendsRecordData({
  String id,
  int status,
  Timestamp timestamp,
}) =>
    serializers.serializeWith(
        FriendsRecord.serializer,
        FriendsRecord((f) => f
          ..id = id
          ..status = status
          ..friends = null
          ..timestamp = timestamp));

FriendsRecord get dummyFriendsRecord {
  final builder = FriendsRecordBuilder()
    ..id = dummyString
    ..status = dummyInteger
    ..timestamp = dummyTimestamp;
  return builder.build();
}

List<FriendsRecord> createDummyFriendsRecord({int count}) =>
    List.generate(count, (_) => dummyFriendsRecord);
