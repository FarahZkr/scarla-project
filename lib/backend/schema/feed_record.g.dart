// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FeedRecord> _$feedRecordSerializer = new _$FeedRecordSerializer();

class _$FeedRecordSerializer implements StructuredSerializer<FeedRecord> {
  @override
  final Iterable<Type> types = const [FeedRecord, _$FeedRecord];
  @override
  final String wireName = 'FeedRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, FeedRecord object,
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
    value = object.authorName;
    if (value != null) {
      result
        ..add('author_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.content;
    if (value != null) {
      result
        ..add('content')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.game;
    if (value != null) {
      result
        ..add('game')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.authorPhotoUrl;
    if (value != null) {
      result
        ..add('author_photo_url')
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
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  FeedRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeedRecordBuilder();

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
        case 'author_name':
          result.authorName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'game':
          result.game = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'author_photo_url':
          result.authorPhotoUrl = serializers.deserialize(value,
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
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$FeedRecord extends FeedRecord {
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String content;
  @override
  final String game;
  @override
  final String id;
  @override
  final int type;
  @override
  final String authorPhotoUrl;
  @override
  final Timestamp timestamp;
  @override
  final DocumentReference authorRef;
  @override
  final String imageUrl;
  @override
  final DocumentReference reference;

  factory _$FeedRecord([void Function(FeedRecordBuilder) updates]) =>
      (new FeedRecordBuilder()..update(updates)).build();

  _$FeedRecord._(
      {this.authorId,
      this.authorName,
      this.content,
      this.game,
      this.id,
      this.type,
      this.authorPhotoUrl,
      this.timestamp,
      this.authorRef,
      this.imageUrl,
      this.reference})
      : super._();

  @override
  FeedRecord rebuild(void Function(FeedRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedRecordBuilder toBuilder() => new FeedRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedRecord &&
        authorId == other.authorId &&
        authorName == other.authorName &&
        content == other.content &&
        game == other.game &&
        id == other.id &&
        type == other.type &&
        authorPhotoUrl == other.authorPhotoUrl &&
        timestamp == other.timestamp &&
        authorRef == other.authorRef &&
        imageUrl == other.imageUrl &&
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
                                        $jc($jc(0, authorId.hashCode),
                                            authorName.hashCode),
                                        content.hashCode),
                                    game.hashCode),
                                id.hashCode),
                            type.hashCode),
                        authorPhotoUrl.hashCode),
                    timestamp.hashCode),
                authorRef.hashCode),
            imageUrl.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeedRecord')
          ..add('authorId', authorId)
          ..add('authorName', authorName)
          ..add('content', content)
          ..add('game', game)
          ..add('id', id)
          ..add('type', type)
          ..add('authorPhotoUrl', authorPhotoUrl)
          ..add('timestamp', timestamp)
          ..add('authorRef', authorRef)
          ..add('imageUrl', imageUrl)
          ..add('reference', reference))
        .toString();
  }
}

class FeedRecordBuilder implements Builder<FeedRecord, FeedRecordBuilder> {
  _$FeedRecord _$v;

  String _authorId;
  String get authorId => _$this._authorId;
  set authorId(String authorId) => _$this._authorId = authorId;

  String _authorName;
  String get authorName => _$this._authorName;
  set authorName(String authorName) => _$this._authorName = authorName;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  String _game;
  String get game => _$this._game;
  set game(String game) => _$this._game = game;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _type;
  int get type => _$this._type;
  set type(int type) => _$this._type = type;

  String _authorPhotoUrl;
  String get authorPhotoUrl => _$this._authorPhotoUrl;
  set authorPhotoUrl(String authorPhotoUrl) =>
      _$this._authorPhotoUrl = authorPhotoUrl;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  DocumentReference _authorRef;
  DocumentReference get authorRef => _$this._authorRef;
  set authorRef(DocumentReference authorRef) => _$this._authorRef = authorRef;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  DocumentReference _reference;
  DocumentReference get reference => _$this._reference;
  set reference(DocumentReference reference) => _$this._reference = reference;

  FeedRecordBuilder() {
    FeedRecord._initializeBuilder(this);
  }

  FeedRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authorId = $v.authorId;
      _authorName = $v.authorName;
      _content = $v.content;
      _game = $v.game;
      _id = $v.id;
      _type = $v.type;
      _authorPhotoUrl = $v.authorPhotoUrl;
      _timestamp = $v.timestamp;
      _authorRef = $v.authorRef;
      _imageUrl = $v.imageUrl;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeedRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FeedRecord;
  }

  @override
  void update(void Function(FeedRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FeedRecord build() {
    final _$result = _$v ??
        new _$FeedRecord._(
            authorId: authorId,
            authorName: authorName,
            content: content,
            game: game,
            id: id,
            type: type,
            authorPhotoUrl: authorPhotoUrl,
            timestamp: timestamp,
            authorRef: authorRef,
            imageUrl: imageUrl,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
