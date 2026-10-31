// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlantCollectionCollection on Isar {
  IsarCollection<PlantCollection> get plantCollections => this.collection();
}

const PlantCollectionSchema = CollectionSchema(
  name: r'PlantCollection',
  id: -7273543481097497049,
  properties: {
    r'acquisitionDate': PropertySchema(
      id: 0,
      name: r'acquisitionDate',
      type: IsarType.dateTime,
    ),
    r'careConfig': PropertySchema(
      id: 1,
      name: r'careConfig',
      type: IsarType.object,
      target: r'CareConfigIsar',
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'cultivationMethod': PropertySchema(
      id: 3,
      name: r'cultivationMethod',
      type: IsarType.string,
    ),
    r'customName': PropertySchema(
      id: 4,
      name: r'customName',
      type: IsarType.string,
    ),
    r'fertilizingConfig': PropertySchema(
      id: 5,
      name: r'fertilizingConfig',
      type: IsarType.object,
      target: r'FertilizingConfigIsar',
    ),
    r'firestoreId': PropertySchema(
      id: 6,
      name: r'firestoreId',
      type: IsarType.string,
    ),
    r'isArchived': PropertySchema(
      id: 7,
      name: r'isArchived',
      type: IsarType.bool,
    ),
    r'localUpdatedAt': PropertySchema(
      id: 8,
      name: r'localUpdatedAt',
      type: IsarType.dateTime,
    ),
    r'notes': PropertySchema(
      id: 9,
      name: r'notes',
      type: IsarType.string,
    ),
    r'photoUrl': PropertySchema(
      id: 10,
      name: r'photoUrl',
      type: IsarType.string,
    ),
    r'roomId': PropertySchema(
      id: 11,
      name: r'roomId',
      type: IsarType.string,
    ),
    r'shelfPosition': PropertySchema(
      id: 12,
      name: r'shelfPosition',
      type: IsarType.long,
    ),
    r'speciesApiId': PropertySchema(
      id: 13,
      name: r'speciesApiId',
      type: IsarType.string,
    ),
    r'speciesCommonName': PropertySchema(
      id: 14,
      name: r'speciesCommonName',
      type: IsarType.string,
    ),
    r'speciesScientificName': PropertySchema(
      id: 15,
      name: r'speciesScientificName',
      type: IsarType.string,
    ),
    r'syncStatusIndex': PropertySchema(
      id: 16,
      name: r'syncStatusIndex',
      type: IsarType.long,
    ),
    r'tags': PropertySchema(
      id: 17,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'thumbnailUrl': PropertySchema(
      id: 18,
      name: r'thumbnailUrl',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 19,
      name: r'userId',
      type: IsarType.string,
    ),
    r'wateringConfig': PropertySchema(
      id: 20,
      name: r'wateringConfig',
      type: IsarType.object,
      target: r'WateringConfigIsar',
    )
  },
  estimateSize: _plantCollectionEstimateSize,
  serialize: _plantCollectionSerialize,
  deserialize: _plantCollectionDeserialize,
  deserializeProp: _plantCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'firestoreId': IndexSchema(
      id: 1863077355534729001,
      name: r'firestoreId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'firestoreId',
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
    ),
    r'roomId': IndexSchema(
      id: -3609232324653216207,
      name: r'roomId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'roomId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'WateringConfigIsar': WateringConfigIsarSchema,
    r'CareConfigIsar': CareConfigIsarSchema,
    r'FertilizingConfigIsar': FertilizingConfigIsarSchema
  },
  getId: _plantCollectionGetId,
  getLinks: _plantCollectionGetLinks,
  attach: _plantCollectionAttach,
  version: '3.1.0+1',
);

int _plantCollectionEstimateSize(
  PlantCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.careConfig;
    if (value != null) {
      bytesCount += 3 +
          CareConfigIsarSchema.estimateSize(
              value, allOffsets[CareConfigIsar]!, allOffsets);
    }
  }
  {
    final value = object.cultivationMethod;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.customName.length * 3;
  {
    final value = object.fertilizingConfig;
    if (value != null) {
      bytesCount += 3 +
          FertilizingConfigIsarSchema.estimateSize(
              value, allOffsets[FertilizingConfigIsar]!, allOffsets);
    }
  }
  bytesCount += 3 + object.firestoreId.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.photoUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.roomId.length * 3;
  {
    final value = object.speciesApiId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.speciesCommonName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.speciesScientificName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.thumbnailUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  {
    final value = object.wateringConfig;
    if (value != null) {
      bytesCount += 3 +
          WateringConfigIsarSchema.estimateSize(
              value, allOffsets[WateringConfigIsar]!, allOffsets);
    }
  }
  return bytesCount;
}

void _plantCollectionSerialize(
  PlantCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.acquisitionDate);
  writer.writeObject<CareConfigIsar>(
    offsets[1],
    allOffsets,
    CareConfigIsarSchema.serialize,
    object.careConfig,
  );
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.cultivationMethod);
  writer.writeString(offsets[4], object.customName);
  writer.writeObject<FertilizingConfigIsar>(
    offsets[5],
    allOffsets,
    FertilizingConfigIsarSchema.serialize,
    object.fertilizingConfig,
  );
  writer.writeString(offsets[6], object.firestoreId);
  writer.writeBool(offsets[7], object.isArchived);
  writer.writeDateTime(offsets[8], object.localUpdatedAt);
  writer.writeString(offsets[9], object.notes);
  writer.writeString(offsets[10], object.photoUrl);
  writer.writeString(offsets[11], object.roomId);
  writer.writeLong(offsets[12], object.shelfPosition);
  writer.writeString(offsets[13], object.speciesApiId);
  writer.writeString(offsets[14], object.speciesCommonName);
  writer.writeString(offsets[15], object.speciesScientificName);
  writer.writeLong(offsets[16], object.syncStatusIndex);
  writer.writeStringList(offsets[17], object.tags);
  writer.writeString(offsets[18], object.thumbnailUrl);
  writer.writeString(offsets[19], object.userId);
  writer.writeObject<WateringConfigIsar>(
    offsets[20],
    allOffsets,
    WateringConfigIsarSchema.serialize,
    object.wateringConfig,
  );
}

PlantCollection _plantCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlantCollection();
  object.acquisitionDate = reader.readDateTimeOrNull(offsets[0]);
  object.careConfig = reader.readObjectOrNull<CareConfigIsar>(
    offsets[1],
    CareConfigIsarSchema.deserialize,
    allOffsets,
  );
  object.createdAt = reader.readDateTime(offsets[2]);
  object.cultivationMethod = reader.readStringOrNull(offsets[3]);
  object.customName = reader.readString(offsets[4]);
  object.fertilizingConfig = reader.readObjectOrNull<FertilizingConfigIsar>(
    offsets[5],
    FertilizingConfigIsarSchema.deserialize,
    allOffsets,
  );
  object.firestoreId = reader.readString(offsets[6]);
  object.id = id;
  object.isArchived = reader.readBool(offsets[7]);
  object.localUpdatedAt = reader.readDateTime(offsets[8]);
  object.notes = reader.readStringOrNull(offsets[9]);
  object.photoUrl = reader.readStringOrNull(offsets[10]);
  object.roomId = reader.readString(offsets[11]);
  object.shelfPosition = reader.readLong(offsets[12]);
  object.speciesApiId = reader.readStringOrNull(offsets[13]);
  object.speciesCommonName = reader.readStringOrNull(offsets[14]);
  object.speciesScientificName = reader.readStringOrNull(offsets[15]);
  object.syncStatusIndex = reader.readLong(offsets[16]);
  object.tags = reader.readStringList(offsets[17]) ?? [];
  object.thumbnailUrl = reader.readStringOrNull(offsets[18]);
  object.userId = reader.readString(offsets[19]);
  object.wateringConfig = reader.readObjectOrNull<WateringConfigIsar>(
    offsets[20],
    WateringConfigIsarSchema.deserialize,
    allOffsets,
  );
  return object;
}

P _plantCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<CareConfigIsar>(
        offset,
        CareConfigIsarSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<FertilizingConfigIsar>(
        offset,
        FertilizingConfigIsarSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readStringList(offset) ?? []) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readObjectOrNull<WateringConfigIsar>(
        offset,
        WateringConfigIsarSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _plantCollectionGetId(PlantCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _plantCollectionGetLinks(PlantCollection object) {
  return [];
}

void _plantCollectionAttach(
    IsarCollection<dynamic> col, Id id, PlantCollection object) {
  object.id = id;
}

extension PlantCollectionByIndex on IsarCollection<PlantCollection> {
  Future<PlantCollection?> getByFirestoreId(String firestoreId) {
    return getByIndex(r'firestoreId', [firestoreId]);
  }

  PlantCollection? getByFirestoreIdSync(String firestoreId) {
    return getByIndexSync(r'firestoreId', [firestoreId]);
  }

  Future<bool> deleteByFirestoreId(String firestoreId) {
    return deleteByIndex(r'firestoreId', [firestoreId]);
  }

  bool deleteByFirestoreIdSync(String firestoreId) {
    return deleteByIndexSync(r'firestoreId', [firestoreId]);
  }

  Future<List<PlantCollection?>> getAllByFirestoreId(
      List<String> firestoreIdValues) {
    final values = firestoreIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'firestoreId', values);
  }

  List<PlantCollection?> getAllByFirestoreIdSync(
      List<String> firestoreIdValues) {
    final values = firestoreIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'firestoreId', values);
  }

  Future<int> deleteAllByFirestoreId(List<String> firestoreIdValues) {
    final values = firestoreIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'firestoreId', values);
  }

  int deleteAllByFirestoreIdSync(List<String> firestoreIdValues) {
    final values = firestoreIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'firestoreId', values);
  }

  Future<Id> putByFirestoreId(PlantCollection object) {
    return putByIndex(r'firestoreId', object);
  }

  Id putByFirestoreIdSync(PlantCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'firestoreId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFirestoreId(List<PlantCollection> objects) {
    return putAllByIndex(r'firestoreId', objects);
  }

  List<Id> putAllByFirestoreIdSync(List<PlantCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'firestoreId', objects, saveLinks: saveLinks);
  }
}

extension PlantCollectionQueryWhereSort
    on QueryBuilder<PlantCollection, PlantCollection, QWhere> {
  QueryBuilder<PlantCollection, PlantCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlantCollectionQueryWhere
    on QueryBuilder<PlantCollection, PlantCollection, QWhereClause> {
  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause> idBetween(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause>
      firestoreIdEqualTo(String firestoreId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'firestoreId',
        value: [firestoreId],
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause>
      firestoreIdNotEqualTo(String firestoreId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firestoreId',
              lower: [],
              upper: [firestoreId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firestoreId',
              lower: [firestoreId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firestoreId',
              lower: [firestoreId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firestoreId',
              lower: [],
              upper: [firestoreId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause>
      userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause>
      userIdNotEqualTo(String userId) {
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause>
      roomIdEqualTo(String roomId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'roomId',
        value: [roomId],
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterWhereClause>
      roomIdNotEqualTo(String roomId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [roomId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'roomId',
              lower: [],
              upper: [roomId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PlantCollectionQueryFilter
    on QueryBuilder<PlantCollection, PlantCollection, QFilterCondition> {
  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      acquisitionDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'acquisitionDate',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      acquisitionDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'acquisitionDate',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      acquisitionDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acquisitionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      acquisitionDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'acquisitionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      acquisitionDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'acquisitionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      acquisitionDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'acquisitionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      careConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'careConfig',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      careConfigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'careConfig',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      createdAtGreaterThan(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cultivationMethod',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cultivationMethod',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cultivationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cultivationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cultivationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cultivationMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cultivationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cultivationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cultivationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cultivationMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cultivationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      cultivationMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cultivationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      customNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      fertilizingConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fertilizingConfig',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      fertilizingConfigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fertilizingConfig',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firestoreId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firestoreId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firestoreId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      firestoreIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firestoreId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      isArchivedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isArchived',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      localUpdatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      localUpdatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      localUpdatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localUpdatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      localUpdatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localUpdatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoUrl',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoUrl',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      photoUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roomId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roomId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roomId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      roomIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roomId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      shelfPositionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shelfPosition',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      shelfPositionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shelfPosition',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      shelfPositionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shelfPosition',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      shelfPositionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shelfPosition',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'speciesApiId',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'speciesApiId',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesApiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speciesApiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speciesApiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speciesApiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'speciesApiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'speciesApiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'speciesApiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'speciesApiId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesApiId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesApiIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'speciesApiId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'speciesCommonName',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'speciesCommonName',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesCommonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speciesCommonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speciesCommonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speciesCommonName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'speciesCommonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'speciesCommonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'speciesCommonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'speciesCommonName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesCommonName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesCommonNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'speciesCommonName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'speciesScientificName',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'speciesScientificName',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesScientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speciesScientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speciesScientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speciesScientificName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'speciesScientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'speciesScientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'speciesScientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'speciesScientificName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speciesScientificName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      speciesScientificNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'speciesScientificName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      syncStatusIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatusIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      syncStatusIndexGreaterThan(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      syncStatusIndexLessThan(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      syncStatusIndexBetween(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailUrl',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailUrl',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      thumbnailUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdEqualTo(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdGreaterThan(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdLessThan(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdBetween(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdStartsWith(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdEndsWith(
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

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      wateringConfigIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wateringConfig',
      ));
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      wateringConfigIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wateringConfig',
      ));
    });
  }
}

extension PlantCollectionQueryObject
    on QueryBuilder<PlantCollection, PlantCollection, QFilterCondition> {
  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      careConfig(FilterQuery<CareConfigIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'careConfig');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      fertilizingConfig(FilterQuery<FertilizingConfigIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'fertilizingConfig');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterFilterCondition>
      wateringConfig(FilterQuery<WateringConfigIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'wateringConfig');
    });
  }
}

extension PlantCollectionQueryLinks
    on QueryBuilder<PlantCollection, PlantCollection, QFilterCondition> {}

extension PlantCollectionQuerySortBy
    on QueryBuilder<PlantCollection, PlantCollection, QSortBy> {
  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByAcquisitionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acquisitionDate', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByAcquisitionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acquisitionDate', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByCultivationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cultivationMethod', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByCultivationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cultivationMethod', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByFirestoreId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByFirestoreIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByLocalUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByLocalUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByPhotoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByPhotoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy> sortByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByShelfPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfPosition', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByShelfPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfPosition', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortBySpeciesApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesApiId', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortBySpeciesApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesApiId', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortBySpeciesCommonName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesCommonName', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortBySpeciesCommonNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesCommonName', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortBySpeciesScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesScientificName', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortBySpeciesScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesScientificName', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortBySyncStatusIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusIndex', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortBySyncStatusIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusIndex', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByThumbnailUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByThumbnailUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension PlantCollectionQuerySortThenBy
    on QueryBuilder<PlantCollection, PlantCollection, QSortThenBy> {
  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByAcquisitionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acquisitionDate', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByAcquisitionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acquisitionDate', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByCultivationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cultivationMethod', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByCultivationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cultivationMethod', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByFirestoreId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByFirestoreIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByLocalUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUpdatedAt', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByLocalUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localUpdatedAt', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByPhotoUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByPhotoUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoUrl', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy> thenByRoomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByRoomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roomId', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByShelfPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfPosition', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByShelfPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelfPosition', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenBySpeciesApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesApiId', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenBySpeciesApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesApiId', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenBySpeciesCommonName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesCommonName', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenBySpeciesCommonNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesCommonName', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenBySpeciesScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesScientificName', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenBySpeciesScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speciesScientificName', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenBySyncStatusIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusIndex', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenBySyncStatusIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatusIndex', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByThumbnailUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByThumbnailUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.desc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension PlantCollectionQueryWhereDistinct
    on QueryBuilder<PlantCollection, PlantCollection, QDistinct> {
  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByAcquisitionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'acquisitionDate');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByCultivationMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cultivationMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByCustomName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByFirestoreId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firestoreId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isArchived');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByLocalUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localUpdatedAt');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct> distinctByPhotoUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct> distinctByRoomId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roomId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByShelfPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shelfPosition');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctBySpeciesApiId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speciesApiId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctBySpeciesCommonName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speciesCommonName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctBySpeciesScientificName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speciesScientificName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctBySyncStatusIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatusIndex');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct>
      distinctByThumbnailUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbnailUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantCollection, PlantCollection, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension PlantCollectionQueryProperty
    on QueryBuilder<PlantCollection, PlantCollection, QQueryProperty> {
  QueryBuilder<PlantCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlantCollection, DateTime?, QQueryOperations>
      acquisitionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'acquisitionDate');
    });
  }

  QueryBuilder<PlantCollection, CareConfigIsar?, QQueryOperations>
      careConfigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'careConfig');
    });
  }

  QueryBuilder<PlantCollection, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PlantCollection, String?, QQueryOperations>
      cultivationMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cultivationMethod');
    });
  }

  QueryBuilder<PlantCollection, String, QQueryOperations> customNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customName');
    });
  }

  QueryBuilder<PlantCollection, FertilizingConfigIsar?, QQueryOperations>
      fertilizingConfigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fertilizingConfig');
    });
  }

  QueryBuilder<PlantCollection, String, QQueryOperations>
      firestoreIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firestoreId');
    });
  }

  QueryBuilder<PlantCollection, bool, QQueryOperations> isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isArchived');
    });
  }

  QueryBuilder<PlantCollection, DateTime, QQueryOperations>
      localUpdatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localUpdatedAt');
    });
  }

  QueryBuilder<PlantCollection, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<PlantCollection, String?, QQueryOperations> photoUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoUrl');
    });
  }

  QueryBuilder<PlantCollection, String, QQueryOperations> roomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roomId');
    });
  }

  QueryBuilder<PlantCollection, int, QQueryOperations> shelfPositionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shelfPosition');
    });
  }

  QueryBuilder<PlantCollection, String?, QQueryOperations>
      speciesApiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speciesApiId');
    });
  }

  QueryBuilder<PlantCollection, String?, QQueryOperations>
      speciesCommonNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speciesCommonName');
    });
  }

  QueryBuilder<PlantCollection, String?, QQueryOperations>
      speciesScientificNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speciesScientificName');
    });
  }

  QueryBuilder<PlantCollection, int, QQueryOperations>
      syncStatusIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatusIndex');
    });
  }

  QueryBuilder<PlantCollection, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<PlantCollection, String?, QQueryOperations>
      thumbnailUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnailUrl');
    });
  }

  QueryBuilder<PlantCollection, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<PlantCollection, WateringConfigIsar?, QQueryOperations>
      wateringConfigProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wateringConfig');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const WateringConfigIsarSchema = Schema(
  name: r'WateringConfigIsar',
  id: -1242150715444607868,
  properties: {
    r'frequencyDays': PropertySchema(
      id: 0,
      name: r'frequencyDays',
      type: IsarType.long,
    ),
    r'lastWateredAt': PropertySchema(
      id: 1,
      name: r'lastWateredAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _wateringConfigIsarEstimateSize,
  serialize: _wateringConfigIsarSerialize,
  deserialize: _wateringConfigIsarDeserialize,
  deserializeProp: _wateringConfigIsarDeserializeProp,
);

int _wateringConfigIsarEstimateSize(
  WateringConfigIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _wateringConfigIsarSerialize(
  WateringConfigIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.frequencyDays);
  writer.writeDateTime(offsets[1], object.lastWateredAt);
}

WateringConfigIsar _wateringConfigIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WateringConfigIsar();
  object.frequencyDays = reader.readLong(offsets[0]);
  object.lastWateredAt = reader.readDateTimeOrNull(offsets[1]);
  return object;
}

P _wateringConfigIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension WateringConfigIsarQueryFilter
    on QueryBuilder<WateringConfigIsar, WateringConfigIsar, QFilterCondition> {
  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      frequencyDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      frequencyDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      frequencyDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      frequencyDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequencyDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      lastWateredAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastWateredAt',
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      lastWateredAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastWateredAt',
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      lastWateredAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastWateredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      lastWateredAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastWateredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      lastWateredAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastWateredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WateringConfigIsar, WateringConfigIsar, QAfterFilterCondition>
      lastWateredAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastWateredAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WateringConfigIsarQueryObject
    on QueryBuilder<WateringConfigIsar, WateringConfigIsar, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CareConfigIsarSchema = Schema(
  name: r'CareConfigIsar',
  id: 3026661571882249684,
  properties: {
    r'fertilizingFrequencyDays': PropertySchema(
      id: 0,
      name: r'fertilizingFrequencyDays',
      type: IsarType.long,
    ),
    r'lastFertilizedAt': PropertySchema(
      id: 1,
      name: r'lastFertilizedAt',
      type: IsarType.dateTime,
    ),
    r'lastRepottedAt': PropertySchema(
      id: 2,
      name: r'lastRepottedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _careConfigIsarEstimateSize,
  serialize: _careConfigIsarSerialize,
  deserialize: _careConfigIsarDeserialize,
  deserializeProp: _careConfigIsarDeserializeProp,
);

int _careConfigIsarEstimateSize(
  CareConfigIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _careConfigIsarSerialize(
  CareConfigIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.fertilizingFrequencyDays);
  writer.writeDateTime(offsets[1], object.lastFertilizedAt);
  writer.writeDateTime(offsets[2], object.lastRepottedAt);
}

CareConfigIsar _careConfigIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CareConfigIsar();
  object.fertilizingFrequencyDays = reader.readLongOrNull(offsets[0]);
  object.lastFertilizedAt = reader.readDateTimeOrNull(offsets[1]);
  object.lastRepottedAt = reader.readDateTimeOrNull(offsets[2]);
  return object;
}

P _careConfigIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CareConfigIsarQueryFilter
    on QueryBuilder<CareConfigIsar, CareConfigIsar, QFilterCondition> {
  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      fertilizingFrequencyDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fertilizingFrequencyDays',
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      fertilizingFrequencyDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fertilizingFrequencyDays',
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      fertilizingFrequencyDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fertilizingFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      fertilizingFrequencyDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fertilizingFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      fertilizingFrequencyDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fertilizingFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      fertilizingFrequencyDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fertilizingFrequencyDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastFertilizedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastFertilizedAt',
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastFertilizedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastFertilizedAt',
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastFertilizedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastFertilizedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastFertilizedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastFertilizedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastFertilizedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastFertilizedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastFertilizedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastFertilizedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastRepottedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRepottedAt',
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastRepottedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRepottedAt',
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastRepottedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRepottedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastRepottedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRepottedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastRepottedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRepottedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CareConfigIsar, CareConfigIsar, QAfterFilterCondition>
      lastRepottedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRepottedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CareConfigIsarQueryObject
    on QueryBuilder<CareConfigIsar, CareConfigIsar, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FertilizingConfigIsarSchema = Schema(
  name: r'FertilizingConfigIsar',
  id: -5277459056318424056,
  properties: {
    r'frequencyDays': PropertySchema(
      id: 0,
      name: r'frequencyDays',
      type: IsarType.long,
    ),
    r'lastFertilizedAt': PropertySchema(
      id: 1,
      name: r'lastFertilizedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _fertilizingConfigIsarEstimateSize,
  serialize: _fertilizingConfigIsarSerialize,
  deserialize: _fertilizingConfigIsarDeserialize,
  deserializeProp: _fertilizingConfigIsarDeserializeProp,
);

int _fertilizingConfigIsarEstimateSize(
  FertilizingConfigIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _fertilizingConfigIsarSerialize(
  FertilizingConfigIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.frequencyDays);
  writer.writeDateTime(offsets[1], object.lastFertilizedAt);
}

FertilizingConfigIsar _fertilizingConfigIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FertilizingConfigIsar();
  object.frequencyDays = reader.readLong(offsets[0]);
  object.lastFertilizedAt = reader.readDateTimeOrNull(offsets[1]);
  return object;
}

P _fertilizingConfigIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FertilizingConfigIsarQueryFilter on QueryBuilder<
    FertilizingConfigIsar, FertilizingConfigIsar, QFilterCondition> {
  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> frequencyDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> frequencyDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> frequencyDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> frequencyDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequencyDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> lastFertilizedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastFertilizedAt',
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> lastFertilizedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastFertilizedAt',
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> lastFertilizedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastFertilizedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> lastFertilizedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastFertilizedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> lastFertilizedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastFertilizedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FertilizingConfigIsar, FertilizingConfigIsar,
      QAfterFilterCondition> lastFertilizedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastFertilizedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FertilizingConfigIsarQueryObject on QueryBuilder<
    FertilizingConfigIsar, FertilizingConfigIsar, QFilterCondition> {}
