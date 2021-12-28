/*
 * Copyright (c) 2021. Scarla
 */

import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_util.dart';
import 'schema/feed_record.dart';
import 'schema/friends_record.dart';
import 'schema/g_messages_record.dart';
import 'schema/games_ranks_record.dart';
import 'schema/groups_record.dart';
import 'schema/serializers.dart';
import 'schema/users_record.dart';

export 'schema/feed_record.dart';
export 'schema/friends_record.dart';
export 'schema/g_messages_record.dart';
export 'schema/games_ranks_record.dart';
export 'schema/groups_record.dart';
export 'schema/users_record.dart';

/// Fait une requête pour la collection [UserRecord]
Stream<List<UsersRecord>> queryUsersRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(UsersRecord.collection, UsersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Fait une requête pour la collection [GroupsRecord]
Stream<List<GroupsRecord>> queryGroupsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(GroupsRecord.collection, GroupsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Fait une requête pour la collection [GMessagesRecord]
Stream<List<GMessagesRecord>> queryGMessagesRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(GMessagesRecord.collection, GMessagesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Fait une requête pour la collection [FeedRecord]
Stream<List<FeedRecord>> queryFeedRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(FeedRecord.collection, FeedRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Fait une requête pour la collection [FriendsRecord]
Stream<List<FriendsRecord>> queryFriendsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(FriendsRecord.collection, FriendsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Fait une requête pour la collection [GamesRanksRecord]
Stream<List<GamesRanksRecord>> queryGamesRanksRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(GamesRanksRecord.collection, GamesRanksRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Fait une requête pour n'importe quelle collection
Stream<List<T>> queryCollection<T>(
    CollectionReference collection, Serializer<T> serializer,
    {Query Function(Query) queryBuilder,
    int limit = -1,
    bool singleRecord = false}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.snapshots().map((s) => s.docs
      .map((d) => serializers.deserializeWith(serializer, serializedData(d)))
      .toList());
}

/// Creates a Firestore record representing the logged in user if it doesn't yet exist
Future maybeCreateUser(User user) async {
  final userRecord = UsersRecord.collection.doc(user.uid);
  final userExists = await userRecord.get().then((u) => u.exists);
  if (userExists) {
    return;
  }

  final userData = createUsersRecordData(
    email: user.email,
    displayName: user.displayName,
    photoUrl: user.photoURL,
    uid: user.uid,
    createdTime: getCurrentTimestamp,
  );

  await userRecord.set(userData);
}
