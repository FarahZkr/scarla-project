// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_ranks_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GamesRanksRecord> _$gamesRanksRecordSerializer =
    new _$GamesRanksRecordSerializer();

class _$GamesRanksRecordSerializer
    implements StructuredSerializer<GamesRanksRecord> {
  @override
  final Iterable<Type> types = const [GamesRanksRecord, _$GamesRanksRecord];
  @override
  final String wireName = 'GamesRanksRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, GamesRanksRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.userRef;
    if (value != null) {
      result
        ..add('userRef')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DocumentReference)));
    }
    value = object.lol;
    if (value != null) {
      result
        ..add('lol')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.valorant;
    if (value != null) {
      result
        ..add('valorant')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.mw;
    if (value != null) {
      result
        ..add('mw')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.ow;
    if (value != null) {
      result
        ..add('ow')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.rl;
    if (value != null) {
      result
        ..add('rl')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  GamesRanksRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GamesRanksRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'userRef':
          result.userRef = serializers.deserialize(value,
                  specifiedType: const FullType(DocumentReference))
              as DocumentReference;
          break;
        case 'lol':
          result.lol = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'valorant':
          result.valorant = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'mw':
          result.mw = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'ow':
          result.ow = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'rl':
          result.rl = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$GamesRanksRecord extends GamesRanksRecord {
  @override
  final DocumentReference userRef;
  @override
  final int lol;
  @override
  final int valorant;
  @override
  final int mw;
  @override
  final int ow;
  @override
  final int rl;
  @override
  final DocumentReference reference;

  factory _$GamesRanksRecord(
          [void Function(GamesRanksRecordBuilder) updates]) =>
      (new GamesRanksRecordBuilder()..update(updates)).build();

  _$GamesRanksRecord._(
      {this.userRef,
      this.lol,
      this.valorant,
      this.mw,
      this.ow,
      this.rl,
      this.reference})
      : super._();

  @override
  GamesRanksRecord rebuild(void Function(GamesRanksRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GamesRanksRecordBuilder toBuilder() =>
      new GamesRanksRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GamesRanksRecord &&
        userRef == other.userRef &&
        lol == other.lol &&
        valorant == other.valorant &&
        mw == other.mw &&
        ow == other.ow &&
        rl == other.rl &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, userRef.hashCode), lol.hashCode),
                        valorant.hashCode),
                    mw.hashCode),
                ow.hashCode),
            rl.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GamesRanksRecord')
          ..add('userRef', userRef)
          ..add('lol', lol)
          ..add('valorant', valorant)
          ..add('mw', mw)
          ..add('ow', ow)
          ..add('rl', rl)
          ..add('reference', reference))
        .toString();
  }
}

class GamesRanksRecordBuilder
    implements Builder<GamesRanksRecord, GamesRanksRecordBuilder> {
  _$GamesRanksRecord _$v;

  DocumentReference _userRef;
  DocumentReference get userRef => _$this._userRef;
  set userRef(DocumentReference userRef) => _$this._userRef = userRef;

  int _lol;
  int get lol => _$this._lol;
  set lol(int lol) => _$this._lol = lol;

  int _valorant;
  int get valorant => _$this._valorant;
  set valorant(int valorant) => _$this._valorant = valorant;

  int _mw;
  int get mw => _$this._mw;
  set mw(int mw) => _$this._mw = mw;

  int _ow;
  int get ow => _$this._ow;
  set ow(int ow) => _$this._ow = ow;

  int _rl;
  int get rl => _$this._rl;
  set rl(int rl) => _$this._rl = rl;

  DocumentReference _reference;
  DocumentReference get reference => _$this._reference;
  set reference(DocumentReference reference) => _$this._reference = reference;

  GamesRanksRecordBuilder() {
    GamesRanksRecord._initializeBuilder(this);
  }

  GamesRanksRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userRef = $v.userRef;
      _lol = $v.lol;
      _valorant = $v.valorant;
      _mw = $v.mw;
      _ow = $v.ow;
      _rl = $v.rl;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GamesRanksRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GamesRanksRecord;
  }

  @override
  void update(void Function(GamesRanksRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GamesRanksRecord build() {
    final _$result = _$v ??
        new _$GamesRanksRecord._(
            userRef: userRef,
            lol: lol,
            valorant: valorant,
            mw: mw,
            ow: ow,
            rl: rl,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
