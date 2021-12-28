// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GroupsRecord> _$groupsRecordSerializer =
    new _$GroupsRecordSerializer();

class _$GroupsRecordSerializer implements StructuredSerializer<GroupsRecord> {
  @override
  final Iterable<Type> types = const [GroupsRecord, _$GroupsRecord];
  @override
  final String wireName = 'GroupsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, GroupsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.gId;
    if (value != null) {
      result
        ..add('g_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.gName;
    if (value != null) {
      result
        ..add('g_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.gPhotoUrl;
    if (value != null) {
      result
        ..add('g_photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastMessage;
    if (value != null) {
      result
        ..add('last_message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastMessageTimestamp;
    if (value != null) {
      result
        ..add('last_message_timestamp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.membersId;
    if (value != null) {
      result
        ..add('members_id')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.host;
    if (value != null) {
      result
        ..add('host')
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
  GroupsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GroupsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'g_id':
          result.gId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'g_name':
          result.gName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'g_photo_url':
          result.gPhotoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_message':
          result.lastMessage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'last_message_timestamp':
          result.lastMessageTimestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'members_id':
          result.membersId.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'host':
          result.host = serializers.deserialize(value,
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

class _$GroupsRecord extends GroupsRecord {
  @override
  final String gId;
  @override
  final String gName;
  @override
  final String gPhotoUrl;
  @override
  final String lastMessage;
  @override
  final Timestamp lastMessageTimestamp;
  @override
  final BuiltList<String> membersId;
  @override
  final DocumentReference host;
  @override
  final DocumentReference reference;

  factory _$GroupsRecord([void Function(GroupsRecordBuilder) updates]) =>
      (new GroupsRecordBuilder()..update(updates)).build();

  _$GroupsRecord._(
      {this.gId,
      this.gName,
      this.gPhotoUrl,
      this.lastMessage,
      this.lastMessageTimestamp,
      this.membersId,
      this.host,
      this.reference})
      : super._();

  @override
  GroupsRecord rebuild(void Function(GroupsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupsRecordBuilder toBuilder() => new GroupsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupsRecord &&
        gId == other.gId &&
        gName == other.gName &&
        gPhotoUrl == other.gPhotoUrl &&
        lastMessage == other.lastMessage &&
        lastMessageTimestamp == other.lastMessageTimestamp &&
        membersId == other.membersId &&
        host == other.host &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, gId.hashCode), gName.hashCode),
                            gPhotoUrl.hashCode),
                        lastMessage.hashCode),
                    lastMessageTimestamp.hashCode),
                membersId.hashCode),
            host.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GroupsRecord')
          ..add('gId', gId)
          ..add('gName', gName)
          ..add('gPhotoUrl', gPhotoUrl)
          ..add('lastMessage', lastMessage)
          ..add('lastMessageTimestamp', lastMessageTimestamp)
          ..add('membersId', membersId)
          ..add('host', host)
          ..add('reference', reference))
        .toString();
  }
}

class GroupsRecordBuilder
    implements Builder<GroupsRecord, GroupsRecordBuilder> {
  _$GroupsRecord _$v;

  String _gId;
  String get gId => _$this._gId;
  set gId(String gId) => _$this._gId = gId;

  String _gName;
  String get gName => _$this._gName;
  set gName(String gName) => _$this._gName = gName;

  String _gPhotoUrl;
  String get gPhotoUrl => _$this._gPhotoUrl;
  set gPhotoUrl(String gPhotoUrl) => _$this._gPhotoUrl = gPhotoUrl;

  String _lastMessage;
  String get lastMessage => _$this._lastMessage;
  set lastMessage(String lastMessage) => _$this._lastMessage = lastMessage;

  Timestamp _lastMessageTimestamp;
  Timestamp get lastMessageTimestamp => _$this._lastMessageTimestamp;
  set lastMessageTimestamp(Timestamp lastMessageTimestamp) =>
      _$this._lastMessageTimestamp = lastMessageTimestamp;

  ListBuilder<String> _membersId;
  ListBuilder<String> get membersId =>
      _$this._membersId ??= new ListBuilder<String>();
  set membersId(ListBuilder<String> membersId) => _$this._membersId = membersId;

  DocumentReference _host;
  DocumentReference get host => _$this._host;
  set host(DocumentReference host) => _$this._host = host;

  DocumentReference _reference;
  DocumentReference get reference => _$this._reference;
  set reference(DocumentReference reference) => _$this._reference = reference;

  GroupsRecordBuilder() {
    GroupsRecord._initializeBuilder(this);
  }

  GroupsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _gId = $v.gId;
      _gName = $v.gName;
      _gPhotoUrl = $v.gPhotoUrl;
      _lastMessage = $v.lastMessage;
      _lastMessageTimestamp = $v.lastMessageTimestamp;
      _membersId = $v.membersId?.toBuilder();
      _host = $v.host;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GroupsRecord;
  }

  @override
  void update(void Function(GroupsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GroupsRecord build() {
    _$GroupsRecord _$result;
    try {
      _$result = _$v ??
          new _$GroupsRecord._(
              gId: gId,
              gName: gName,
              gPhotoUrl: gPhotoUrl,
              lastMessage: lastMessage,
              lastMessageTimestamp: lastMessageTimestamp,
              membersId: _membersId?.build(),
              host: host,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'membersId';
        _membersId?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'GroupsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
