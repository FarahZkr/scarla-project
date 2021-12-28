// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'g_messages_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMessagesRecord> _$gMessagesRecordSerializer =
    new _$GMessagesRecordSerializer();

class _$GMessagesRecordSerializer
    implements StructuredSerializer<GMessagesRecord> {
  @override
  final Iterable<Type> types = const [GMessagesRecord, _$GMessagesRecord];
  @override
  final String wireName = 'GMessagesRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, GMessagesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.authorId;
    if (value != null) {
      result
        ..add('author_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.groupRef;
    if (value != null) {
      result
        ..add('group_ref')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DocumentReference)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.timestamp;
    if (value != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.authorRef;
    if (value != null) {
      result
        ..add('author_ref')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DocumentReference)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DocumentReference)));
    }
    return result;
  }

  @override
  GMessagesRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMessagesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'author_id':
          result.authorId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'group_ref':
          result.groupRef = serializers.deserialize(value,
                  specifiedType: const FullType(DocumentReference))
              as DocumentReference;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'author_ref':
          result.authorRef = serializers.deserialize(value,
                  specifiedType: const FullType(DocumentReference))
              as DocumentReference;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(DocumentReference))
              as DocumentReference;
          break;
      }
    }

    return result.build();
  }
}

class _$GMessagesRecord extends GMessagesRecord {
  @override
  final String authorId;
  @override
  final DocumentReference groupRef;
  @override
  final int type;
  @override
  final String value;
  @override
  final Timestamp timestamp;
  @override
  final DocumentReference authorRef;
  @override
  final DocumentReference reference;

  factory _$GMessagesRecord([void Function(GMessagesRecordBuilder) updates]) =>
      (new GMessagesRecordBuilder()..update(updates)).build();

  _$GMessagesRecord._(
      {this.authorId,
      this.groupRef,
      this.type,
      this.value,
      this.timestamp,
      this.authorRef,
      this.reference})
      : super._();

  @override
  GMessagesRecord rebuild(void Function(GMessagesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMessagesRecordBuilder toBuilder() =>
      new GMessagesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMessagesRecord &&
        authorId == other.authorId &&
        groupRef == other.groupRef &&
        type == other.type &&
        value == other.value &&
        timestamp == other.timestamp &&
        authorRef == other.authorRef &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, authorId.hashCode), groupRef.hashCode),
                        type.hashCode),
                    value.hashCode),
                timestamp.hashCode),
            authorRef.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GMessagesRecord')
          ..add('authorId', authorId)
          ..add('groupRef', groupRef)
          ..add('type', type)
          ..add('value', value)
          ..add('timestamp', timestamp)
          ..add('authorRef', authorRef)
          ..add('reference', reference))
        .toString();
  }
}

class GMessagesRecordBuilder
    implements Builder<GMessagesRecord, GMessagesRecordBuilder> {
  _$GMessagesRecord _$v;

  String _authorId;
  String get authorId => _$this._authorId;
  set authorId(String authorId) => _$this._authorId = authorId;

  DocumentReference _groupRef;
  DocumentReference get groupRef => _$this._groupRef;
  set groupRef(DocumentReference groupRef) => _$this._groupRef = groupRef;

  int _type;
  int get type => _$this._type;
  set type(int type) => _$this._type = type;

  String _value;
  String get value => _$this._value;
  set value(String value) => _$this._value = value;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  DocumentReference _authorRef;
  DocumentReference get authorRef => _$this._authorRef;
  set authorRef(DocumentReference authorRef) => _$this._authorRef = authorRef;

  DocumentReference _reference;
  DocumentReference get reference => _$this._reference;
  set reference(DocumentReference reference) => _$this._reference = reference;

  GMessagesRecordBuilder() {
    GMessagesRecord._initializeBuilder(this);
  }

  GMessagesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authorId = $v.authorId;
      _groupRef = $v.groupRef;
      _type = $v.type;
      _value = $v.value;
      _timestamp = $v.timestamp;
      _authorRef = $v.authorRef;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMessagesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMessagesRecord;
  }

  @override
  void update(void Function(GMessagesRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GMessagesRecord build() {
    final _$result = _$v ??
        new _$GMessagesRecord._(
            authorId: authorId,
            groupRef: groupRef,
            type: type,
            value: value,
            timestamp: timestamp,
            authorRef: authorRef,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
