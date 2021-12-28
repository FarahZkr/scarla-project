// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsersRecord> _$usersRecordSerializer = new _$UsersRecordSerializer();

class _$UsersRecordSerializer implements StructuredSerializer<UsersRecord> {
  @override
  final Iterable<Type> types = const [UsersRecord, _$UsersRecord];
  @override
  final String wireName = 'UsersRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, UsersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.about;
    if (value != null) {
      result
        ..add('about')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.bgProfile;
    if (value != null) {
      result
        ..add('bgProfile')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tag;
    if (value != null) {
      result
        ..add('TAG')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isCompetitive;
    if (value != null) {
      result
        ..add('isCompetitive')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isToxic;
    if (value != null) {
      result
        ..add('isToxic')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.ranksRef;
    if (value != null) {
      result
        ..add('ranksRef')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DocumentReference)));
    }
    value = object.createdTime;
    if (value != null) {
      result
        ..add('created_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.selectedGames;
    if (value != null) {
      result
        ..add('selected_games')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.keys;
    if (value != null) {
      result
        ..add('keys')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
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
  UsersRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'about':
          result.about = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bgProfile':
          result.bgProfile = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'TAG':
          result.tag = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isCompetitive':
          result.isCompetitive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isToxic':
          result.isToxic = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'ranksRef':
          result.ranksRef = serializers.deserialize(value,
                  specifiedType: const FullType(DocumentReference))
              as DocumentReference;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'selected_games':
          result.selectedGames.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'keys':
          result.keys.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
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

class _$UsersRecord extends UsersRecord {
  @override
  final String about;
  @override
  final String name;
  @override
  final String photoUrl;
  @override
  final String bgProfile;
  @override
  final String email;
  @override
  final String displayName;
  @override
  final String tag;
  @override
  final bool isCompetitive;
  @override
  final bool isToxic;
  @override
  final DocumentReference ranksRef;
  @override
  final Timestamp createdTime;
  @override
  final String uid;
  @override
  final BuiltList<String> selectedGames;
  @override
  final BuiltList<String> keys;
  @override
  final DocumentReference reference;

  factory _$UsersRecord([void Function(UsersRecordBuilder) updates]) =>
      (new UsersRecordBuilder()..update(updates)).build();

  _$UsersRecord._(
      {this.about,
      this.name,
      this.photoUrl,
      this.bgProfile,
      this.email,
      this.displayName,
      this.tag,
      this.isCompetitive,
      this.isToxic,
      this.ranksRef,
      this.createdTime,
      this.uid,
      this.selectedGames,
      this.keys,
      this.reference})
      : super._();

  @override
  UsersRecord rebuild(void Function(UsersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersRecordBuilder toBuilder() => new UsersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersRecord &&
        about == other.about &&
        name == other.name &&
        photoUrl == other.photoUrl &&
        bgProfile == other.bgProfile &&
        email == other.email &&
        displayName == other.displayName &&
        tag == other.tag &&
        isCompetitive == other.isCompetitive &&
        isToxic == other.isToxic &&
        ranksRef == other.ranksRef &&
        createdTime == other.createdTime &&
        uid == other.uid &&
        selectedGames == other.selectedGames &&
        keys == other.keys &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(0,
                                                                about.hashCode),
                                                            name.hashCode),
                                                        photoUrl.hashCode),
                                                    bgProfile.hashCode),
                                                email.hashCode),
                                            displayName.hashCode),
                                        tag.hashCode),
                                    isCompetitive.hashCode),
                                isToxic.hashCode),
                            ranksRef.hashCode),
                        createdTime.hashCode),
                    uid.hashCode),
                selectedGames.hashCode),
            keys.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UsersRecord')
          ..add('about', about)
          ..add('name', name)
          ..add('photoUrl', photoUrl)
          ..add('bgProfile', bgProfile)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('tag', tag)
          ..add('isCompetitive', isCompetitive)
          ..add('isToxic', isToxic)
          ..add('ranksRef', ranksRef)
          ..add('createdTime', createdTime)
          ..add('uid', uid)
          ..add('selectedGames', selectedGames)
          ..add('keys', keys)
          ..add('reference', reference))
        .toString();
  }
}

class UsersRecordBuilder implements Builder<UsersRecord, UsersRecordBuilder> {
  _$UsersRecord _$v;

  String _about;
  String get about => _$this._about;
  set about(String about) => _$this._about = about;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _photoUrl;
  String get photoUrl => _$this._photoUrl;
  set photoUrl(String photoUrl) => _$this._photoUrl = photoUrl;

  String _bgProfile;
  String get bgProfile => _$this._bgProfile;
  set bgProfile(String bgProfile) => _$this._bgProfile = bgProfile;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _tag;
  String get tag => _$this._tag;
  set tag(String tag) => _$this._tag = tag;

  bool _isCompetitive;
  bool get isCompetitive => _$this._isCompetitive;
  set isCompetitive(bool isCompetitive) =>
      _$this._isCompetitive = isCompetitive;

  bool _isToxic;
  bool get isToxic => _$this._isToxic;
  set isToxic(bool isToxic) => _$this._isToxic = isToxic;

  DocumentReference _ranksRef;
  DocumentReference get ranksRef => _$this._ranksRef;
  set ranksRef(DocumentReference ranksRef) => _$this._ranksRef = ranksRef;

  Timestamp _createdTime;
  Timestamp get createdTime => _$this._createdTime;
  set createdTime(Timestamp createdTime) => _$this._createdTime = createdTime;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  ListBuilder<String> _selectedGames;
  ListBuilder<String> get selectedGames =>
      _$this._selectedGames ??= new ListBuilder<String>();
  set selectedGames(ListBuilder<String> selectedGames) =>
      _$this._selectedGames = selectedGames;

  ListBuilder<String> _keys;
  ListBuilder<String> get keys => _$this._keys ??= new ListBuilder<String>();
  set keys(ListBuilder<String> keys) => _$this._keys = keys;

  DocumentReference _reference;
  DocumentReference get reference => _$this._reference;
  set reference(DocumentReference reference) => _$this._reference = reference;

  UsersRecordBuilder() {
    UsersRecord._initializeBuilder(this);
  }

  UsersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _about = $v.about;
      _name = $v.name;
      _photoUrl = $v.photoUrl;
      _bgProfile = $v.bgProfile;
      _email = $v.email;
      _displayName = $v.displayName;
      _tag = $v.tag;
      _isCompetitive = $v.isCompetitive;
      _isToxic = $v.isToxic;
      _ranksRef = $v.ranksRef;
      _createdTime = $v.createdTime;
      _uid = $v.uid;
      _selectedGames = $v.selectedGames?.toBuilder();
      _keys = $v.keys?.toBuilder();
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsersRecord;
  }

  @override
  void update(void Function(UsersRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UsersRecord build() {
    _$UsersRecord _$result;
    try {
      _$result = _$v ??
          new _$UsersRecord._(
              about: about,
              name: name,
              photoUrl: photoUrl,
              bgProfile: bgProfile,
              email: email,
              displayName: displayName,
              tag: tag,
              isCompetitive: isCompetitive,
              isToxic: isToxic,
              ranksRef: ranksRef,
              createdTime: createdTime,
              uid: uid,
              selectedGames: _selectedGames?.build(),
              keys: _keys?.build(),
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'selectedGames';
        _selectedGames?.build();
        _$failedField = 'keys';
        _keys?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UsersRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
