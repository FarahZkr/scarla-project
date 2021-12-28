/*
 * Copyright (c) 2021. Scarla
 */

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'g_messages_record.g.dart';

/// Classe de la collection [GMessagesRecord] dans la base de données Firebase
///
/// Contient tous les champs de la collection [GMessagesRecord]
abstract class GMessagesRecord
    implements Built<GMessagesRecord, GMessagesRecordBuilder> {
  static Serializer<GMessagesRecord> get serializer =>
      _$gMessagesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'author_id')
  String get authorId;

  @nullable
  @BuiltValueField(wireName: 'group_ref')
  DocumentReference get groupRef;

  @nullable
  int get type;

  @nullable
  String get value;

  @nullable
  Timestamp get timestamp;

  @nullable
  @BuiltValueField(wireName: 'author_ref')
  DocumentReference get authorRef;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GMessagesRecordBuilder builder) => builder
    ..authorId = ''
    ..type = 0
    ..value = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('g_messages');

  static Stream<GMessagesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GMessagesRecord._();

  factory GMessagesRecord([void Function(GMessagesRecordBuilder) updates]) =
      _$GMessagesRecord;
}

Map<String, dynamic> createGMessagesRecordData({
  String authorId,
  DocumentReference groupRef,
  int type,
  String value,
  Timestamp timestamp,
  DocumentReference authorRef,
}) =>
    serializers.serializeWith(
        GMessagesRecord.serializer,
        GMessagesRecord((g) => g
          ..authorId = authorId
          ..groupRef = groupRef
          ..type = type
          ..value = value
          ..timestamp = timestamp
          ..authorRef = authorRef));

GMessagesRecord get dummyGMessagesRecord {
  final builder = GMessagesRecordBuilder()
    ..authorId = dummyString
    ..type = dummyInteger
    ..value = dummyString
    ..timestamp = dummyTimestamp;
  return builder.build();
}

List<GMessagesRecord> createDummyGMessagesRecord({int count}) =>
    List.generate(count, (_) => dummyGMessagesRecord);
