// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FriendsRecord> _$friendsRecordSerializer =
    new _$FriendsRecordSerializer();

class _$FriendsRecordSerializer implements StructuredSerializer<FriendsRecord> {
  @override
  final Iterable<Type> types = const [FriendsRecord, _$FriendsRecord];
  @override
  final String wireName = 'FriendsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, FriendsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.friends;
    if (value != null) {
      result
        ..add('friends')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(DocumentReference)])));
    }
    value = object.timestamp;
    if (value != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
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
  FriendsRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FriendsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'friends':
          result.friends.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(DocumentReference)]))
              as BuiltList<Object>);
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
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

class _$FriendsRecord extends FriendsRecord {
  @override
  final String id;
  @override
  final int status;
  @override
  final BuiltList<DocumentReference> friends;
  @override
  final Timestamp timestamp;
  @override
  final DocumentReference reference;

  factory _$FriendsRecord([void Function(FriendsRecordBuilder) updates]) =>
      (new FriendsRecordBuilder()..update(updates)).build();

  _$FriendsRecord._(
      {this.id, this.status, this.friends, this.timestamp, this.reference})
      : super._();

  @override
  FriendsRecord rebuild(void Function(FriendsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendsRecordBuilder toBuilder() => new FriendsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendsRecord &&
        id == other.id &&
        status == other.status &&
        friends == other.friends &&
        timestamp == other.timestamp &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), status.hashCode), friends.hashCode),
            timestamp.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FriendsRecord')
          ..add('id', id)
          ..add('status', status)
          ..add('friends', friends)
          ..add('timestamp', timestamp)
          ..add('reference', reference))
        .toString();
  }
}

class FriendsRecordBuilder
    implements Builder<FriendsRecord, FriendsRecordBuilder> {
  _$FriendsRecord _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _status;
  int get status => _$this._status;
  set status(int status) => _$this._status = status;

  ListBuilder<DocumentReference> _friends;
  ListBuilder<DocumentReference> get friends =>
      _$this._friends ??= new ListBuilder<DocumentReference>();
  set friends(ListBuilder<DocumentReference> friends) =>
      _$this._friends = friends;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  DocumentReference _reference;
  DocumentReference get reference => _$this._reference;
  set reference(DocumentReference reference) => _$this._reference = reference;

  FriendsRecordBuilder() {
    FriendsRecord._initializeBuilder(this);
  }

  FriendsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _status = $v.status;
      _friends = $v.friends?.toBuilder();
      _timestamp = $v.timestamp;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FriendsRecord;
  }

  @override
  void update(void Function(FriendsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FriendsRecord build() {
    _$FriendsRecord _$result;
    try {
      _$result = _$v ??
          new _$FriendsRecord._(
              id: id,
              status: status,
              friends: _friends?.build(),
              timestamp: timestamp,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'friends';
        _friends?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FriendsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
