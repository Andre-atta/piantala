// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_operation_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPendingOperationCollectionCollection on Isar {
  IsarCollection<PendingOperationCollection> get pendingOperationCollections =>
      this.collection();
}

const PendingOperationCollectionSchema = CollectionSchema(
  name: r'PendingOperationCollection',
  id: -6885010264946527864,
  properties: {
    r'attemptCount': PropertySchema(
      id: 0,
      name: r'attemptCount',
      type: IsarType.long,
    ),
    r'collectionPath': PropertySchema(
      id: 1,
      name: r'collectionPath',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'documentId': PropertySchema(
      id: 3,
      name: r'documentId',
      type: IsarType.string,
    ),
    r'lastAttemptAt': PropertySchema(
      id: 4,
      name: r'lastAttemptAt',
      type: IsarType.dateTime,
    ),
    r'operation': PropertySchema(
      id: 5,
      name: r'operation',
      type: IsarType.string,
    ),
    r'operationId': PropertySchema(
      id: 6,
      name: r'operationId',
      type: IsarType.string,
    ),
    r'payloadJson': PropertySchema(
      id: 7,
      name: r'payloadJson',
      type: IsarType.string,
    ),
    r'syncStatusIndex': PropertySchema(
      id: 8,
      name: r'syncStatusIndex',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 9,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _pendingOperationCollectionEstimateSize,
  serialize: _pendingOperationCollectionSerialize,
  deserialize: _pendingOperationCollectionDeserialize,
  deserializeProp: _pendingOperationCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'operationId': IndexSchema(
      id: 7498062369325286803,
      name: r'operationId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'operationId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _pendingOperationCollectionGetId,
  getLinks: _pendingOperationCollectionGetLinks,
  attach: _pendingOperationCollectionAttach,
  version: '3.1.0+1',
);

int _pendingOperationCollectionEstimateSize(
  PendingOperationCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.collectionPath.length * 3;
  bytesCount += 3 + object.documentId.length * 3;
  bytesCount += 3 + object.operation.length * 3;
  bytesCount += 3 + object.operationId.length * 3;
  bytesCount += 3 + object.payloadJson.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _pendingOperationCollectionSerialize(
  PendingOperationCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.attemptCount);
  writer.writeString(offsets[1], object.collectionPath);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.documentId);
  writer.writeDateTime(offsets[4], object.lastAttemptAt);
  writer.writeString(offsets[5], object.operation);
  writer.writeString(offsets[6], object.operationId);
  writer.writeString(offsets[7], object.payloadJson);
  writer.writeLong(offsets[8], object.syncStatusIndex);
  writer.writeString(offsets[9], object.userId);
}

PendingOperationCollection _pendingOperationCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PendingOperationCollection();
  object.attemptCount = reader.readLong(offsets[0]);
  object.collectionPath = reader.readString(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.documentId = reader.readString(offsets[3]);
  object.id = id;
  object.lastAttemptAt = reader.readDateTimeOrNull(offsets[4]);
  object.operation = reader.readString(offsets[5]);
  object.operationId = reader.readString(offsets[6]);
  object.payloadJson = reader.readString(offsets[7]);
  object.userId = reader.readString(offsets[9]);
  return object;
}

P _pendingOperationCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pendingOperationCollectionGetId(PendingOperationCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pendingOperationCollectionGetLinks(
    PendingOperationCollection object) {
  return [];
}

void _pendingOperationCollectionAttach(
    IsarCollection<dynamic> col, Id id, PendingOperationCollection object) {
  object.id = id;
}

extension PendingOperationCollectionByIndex
    on IsarCollection<PendingOperationCollection> {
  Future<PendingOperationCollection?> getByOperationId(String operationId) {
    return getByIndex(r'operationId', [operationId]);
  }

  PendingOperationCollection? getByOperationIdSync(String operationId) {
    return getByIndexSync(r'operationId', [operationId]);
  }

  Future<bool> deleteByOperationId(String operationId) {
    return deleteByIndex(r'operationId', [operationId]);
  }

  bool deleteByOperationIdSync(String operationId) {
    return deleteByIndexSync(r'operationId', [operationId]);
  }

  Future<List<PendingOperationCollection?>> getAllByOperationId(
      List<String> operationIdValues) {
    final values = operationIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'operationId', values);
  }

  List<PendingOperationCollection?> getAllByOperationIdSync(
      List<String> operationIdValues) {
    final values = operationIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'operationId', values);
  }

  Future<int> deleteAllByOperationId(List<String> operationIdValues) {
    final values = operationIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'operationId', values);
  }

  int deleteAllByOperationIdSync(List<String> operationIdValues) {
    final values = operationIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'operationId', values);
  }

  Future<Id> putByOperationId(PendingOperationCollection object) {
    return putByIndex(r'operationId', object);
  }

  Id putByOperationIdSync(PendingOperationCollection object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'operationId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByOperationId(
      List<PendingOperationCollection> objects) {
    return putAllByIndex(r'operationId', objects);
  }

  List<Id> putAllByOperationIdSync(List<PendingOperationCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'operationId', objects, saveLinks: saveLinks);
  }
}

extension PendingOperationCollectionQueryWhereSort on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QWhere> {
  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PendingOperationCollectionQueryWhere on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QWhereClause> {
  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> operationIdEqualTo(String operationId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'operationId',
        value: [operationId],
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> operationIdNotEqualTo(String operationId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'operationId',
              lower: [],
              upper: [operationId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'operationId',
              lower: [operationId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'operationId',
              lower: [operationId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'operationId',
              lower: [],
              upper: [operationId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterWhereClause> userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PendingOperationCollectionQueryFilter on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QFilterCondition> {
  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> attemptCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> attemptCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> attemptCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> attemptCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attemptCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> collectionPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> collectionPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collectionPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> collectionPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collectionPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> collectionPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collectionPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> collectionPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'collectionPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> collectionPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'collectionPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      collectionPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'collectionPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      collectionPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'collectionPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> collectionPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionPath',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> collectionPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'collectionPath',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> documentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> documentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> documentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> documentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> documentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> documentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      documentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      documentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> documentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentId',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> documentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentId',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> lastAttemptAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> lastAttemptAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> lastAttemptAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> lastAttemptAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> lastAttemptAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> lastAttemptAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAttemptAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'operation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      operationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      operationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'operation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operation',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'operation',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'operationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'operationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'operationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'operationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'operationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      operationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'operationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      operationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'operationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operationId',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> operationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'operationId',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> payloadJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> payloadJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> payloadJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> payloadJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'payloadJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> payloadJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> payloadJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      payloadJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'payloadJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      payloadJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'payloadJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> payloadJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'payloadJson',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> payloadJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'payloadJson',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> syncStatusIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatusIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> syncStatusIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncStatusIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> syncStatusIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncStatusIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> syncStatusIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncStatusIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
          QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension PendingOperationCollectionQueryObject on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QFilterCondition> {}

extension PendingOperationCollectionQueryLinks on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QFilterCondition> {}

extension PendingOperationCollectionQuerySortBy on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QSortBy> {
  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByCollectionPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionPath', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByCollectionPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionPath', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByDocumentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentId', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByDocumentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentId', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operation', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operation', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByOperationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operationId', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByOperationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operationId', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByPayloadJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByPayloadJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortBySyncStatusIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusIndex', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortBySyncStatusIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusIndex', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension PendingOperationCollectionQuerySortThenBy on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QSortThenBy> {
  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByCollectionPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionPath', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByCollectionPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionPath', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByDocumentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentId', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByDocumentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentId', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operation', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operation', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByOperationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operationId', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByOperationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operationId', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByPayloadJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByPayloadJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'payloadJson', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenBySyncStatusIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusIndex', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenBySyncStatusIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusIndex', Sort.desc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension PendingOperationCollectionQueryWhereDistinct on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QDistinct> {
  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attemptCount');
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByCollectionPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collectionPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByDocumentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAttemptAt');
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByOperation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'operation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByOperationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'operationId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByPayloadJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'payloadJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctBySyncStatusIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatusIndex');
    });
  }

  QueryBuilder<PendingOperationCollection, PendingOperationCollection,
      QDistinct> distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension PendingOperationCollectionQueryProperty on QueryBuilder<
    PendingOperationCollection, PendingOperationCollection, QQueryProperty> {
  QueryBuilder<PendingOperationCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PendingOperationCollection, int, QQueryOperations>
      attemptCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attemptCount');
    });
  }

  QueryBuilder<PendingOperationCollection, String, QQueryOperations>
      collectionPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collectionPath');
    });
  }

  QueryBuilder<PendingOperationCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PendingOperationCollection, String, QQueryOperations>
      documentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentId');
    });
  }

  QueryBuilder<PendingOperationCollection, DateTime?, QQueryOperations>
      lastAttemptAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAttemptAt');
    });
  }

  QueryBuilder<PendingOperationCollection, String, QQueryOperations>
      operationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operation');
    });
  }

  QueryBuilder<PendingOperationCollection, String, QQueryOperations>
      operationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operationId');
    });
  }

  QueryBuilder<PendingOperationCollection, String, QQueryOperations>
      payloadJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payloadJson');
    });
  }

  QueryBuilder<PendingOperationCollection, int, QQueryOperations>
      syncStatusIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatusIndex');
    });
  }

  QueryBuilder<PendingOperationCollection, String, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
