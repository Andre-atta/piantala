// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_cache_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSpeciesCacheCollectionCollection on Isar {
  IsarCollection<SpeciesCacheCollection> get speciesCacheCollections =>
      this.collection();
}

const SpeciesCacheCollectionSchema = CollectionSchema(
  name: r'SpeciesCacheCollection',
  id: -8291963632363479285,
  properties: {
    r'apiId': PropertySchema(
      id: 0,
      name: r'apiId',
      type: IsarType.string,
    ),
    r'cachedAt': PropertySchema(
      id: 1,
      name: r'cachedAt',
      type: IsarType.dateTime,
    ),
    r'careFertilization': PropertySchema(
      id: 2,
      name: r'careFertilization',
      type: IsarType.string,
    ),
    r'carePruning': PropertySchema(
      id: 3,
      name: r'carePruning',
      type: IsarType.string,
    ),
    r'careSoil': PropertySchema(
      id: 4,
      name: r'careSoil',
      type: IsarType.string,
    ),
    r'commonName': PropertySchema(
      id: 5,
      name: r'commonName',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 6,
      name: r'description',
      type: IsarType.string,
    ),
    r'directSunTolerance': PropertySchema(
      id: 7,
      name: r'directSunTolerance',
      type: IsarType.bool,
    ),
    r'droughtTolerant': PropertySchema(
      id: 8,
      name: r'droughtTolerant',
      type: IsarType.bool,
    ),
    r'family': PropertySchema(
      id: 9,
      name: r'family',
      type: IsarType.string,
    ),
    r'funFacts': PropertySchema(
      id: 10,
      name: r'funFacts',
      type: IsarType.stringList,
    ),
    r'humidityRequirement': PropertySchema(
      id: 11,
      name: r'humidityRequirement',
      type: IsarType.string,
    ),
    r'imageUrl': PropertySchema(
      id: 12,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'lightLuxMax': PropertySchema(
      id: 13,
      name: r'lightLuxMax',
      type: IsarType.long,
    ),
    r'lightLuxMin': PropertySchema(
      id: 14,
      name: r'lightLuxMin',
      type: IsarType.long,
    ),
    r'lightMmolMax': PropertySchema(
      id: 15,
      name: r'lightMmolMax',
      type: IsarType.long,
    ),
    r'lightMmolMin': PropertySchema(
      id: 16,
      name: r'lightMmolMin',
      type: IsarType.long,
    ),
    r'lightRequirement': PropertySchema(
      id: 17,
      name: r'lightRequirement',
      type: IsarType.string,
    ),
    r'needsMisting': PropertySchema(
      id: 18,
      name: r'needsMisting',
      type: IsarType.bool,
    ),
    r'origin': PropertySchema(
      id: 19,
      name: r'origin',
      type: IsarType.string,
    ),
    r'propagationMethods': PropertySchema(
      id: 20,
      name: r'propagationMethods',
      type: IsarType.stringList,
    ),
    r'scientificName': PropertySchema(
      id: 21,
      name: r'scientificName',
      type: IsarType.string,
    ),
    r'soilEcMax': PropertySchema(
      id: 22,
      name: r'soilEcMax',
      type: IsarType.long,
    ),
    r'soilEcMin': PropertySchema(
      id: 23,
      name: r'soilEcMin',
      type: IsarType.long,
    ),
    r'soilMoistMax': PropertySchema(
      id: 24,
      name: r'soilMoistMax',
      type: IsarType.long,
    ),
    r'soilMoistMin': PropertySchema(
      id: 25,
      name: r'soilMoistMin',
      type: IsarType.long,
    ),
    r'temperatureMax': PropertySchema(
      id: 26,
      name: r'temperatureMax',
      type: IsarType.long,
    ),
    r'temperatureMin': PropertySchema(
      id: 27,
      name: r'temperatureMin',
      type: IsarType.long,
    ),
    r'thumbnailUrl': PropertySchema(
      id: 28,
      name: r'thumbnailUrl',
      type: IsarType.string,
    ),
    r'ttlDays': PropertySchema(
      id: 29,
      name: r'ttlDays',
      type: IsarType.long,
    ),
    r'wateringFrequencyDays': PropertySchema(
      id: 30,
      name: r'wateringFrequencyDays',
      type: IsarType.long,
    )
  },
  estimateSize: _speciesCacheCollectionEstimateSize,
  serialize: _speciesCacheCollectionSerialize,
  deserialize: _speciesCacheCollectionDeserialize,
  deserializeProp: _speciesCacheCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'apiId': IndexSchema(
      id: 92618221247000178,
      name: r'apiId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'apiId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _speciesCacheCollectionGetId,
  getLinks: _speciesCacheCollectionGetLinks,
  attach: _speciesCacheCollectionAttach,
  version: '3.1.0+1',
);

int _speciesCacheCollectionEstimateSize(
  SpeciesCacheCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.apiId.length * 3;
  {
    final value = object.careFertilization;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.carePruning;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.careSoil;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.commonName.length * 3;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.family;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.funFacts.length * 3;
  {
    for (var i = 0; i < object.funFacts.length; i++) {
      final value = object.funFacts[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.humidityRequirement.length * 3;
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.lightRequirement.length * 3;
  {
    final value = object.origin;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.propagationMethods.length * 3;
  {
    for (var i = 0; i < object.propagationMethods.length; i++) {
      final value = object.propagationMethods[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.scientificName.length * 3;
  {
    final value = object.thumbnailUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _speciesCacheCollectionSerialize(
  SpeciesCacheCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.apiId);
  writer.writeDateTime(offsets[1], object.cachedAt);
  writer.writeString(offsets[2], object.careFertilization);
  writer.writeString(offsets[3], object.carePruning);
  writer.writeString(offsets[4], object.careSoil);
  writer.writeString(offsets[5], object.commonName);
  writer.writeString(offsets[6], object.description);
  writer.writeBool(offsets[7], object.directSunTolerance);
  writer.writeBool(offsets[8], object.droughtTolerant);
  writer.writeString(offsets[9], object.family);
  writer.writeStringList(offsets[10], object.funFacts);
  writer.writeString(offsets[11], object.humidityRequirement);
  writer.writeString(offsets[12], object.imageUrl);
  writer.writeLong(offsets[13], object.lightLuxMax);
  writer.writeLong(offsets[14], object.lightLuxMin);
  writer.writeLong(offsets[15], object.lightMmolMax);
  writer.writeLong(offsets[16], object.lightMmolMin);
  writer.writeString(offsets[17], object.lightRequirement);
  writer.writeBool(offsets[18], object.needsMisting);
  writer.writeString(offsets[19], object.origin);
  writer.writeStringList(offsets[20], object.propagationMethods);
  writer.writeString(offsets[21], object.scientificName);
  writer.writeLong(offsets[22], object.soilEcMax);
  writer.writeLong(offsets[23], object.soilEcMin);
  writer.writeLong(offsets[24], object.soilMoistMax);
  writer.writeLong(offsets[25], object.soilMoistMin);
  writer.writeLong(offsets[26], object.temperatureMax);
  writer.writeLong(offsets[27], object.temperatureMin);
  writer.writeString(offsets[28], object.thumbnailUrl);
  writer.writeLong(offsets[29], object.ttlDays);
  writer.writeLong(offsets[30], object.wateringFrequencyDays);
}

SpeciesCacheCollection _speciesCacheCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SpeciesCacheCollection();
  object.apiId = reader.readString(offsets[0]);
  object.cachedAt = reader.readDateTime(offsets[1]);
  object.careFertilization = reader.readStringOrNull(offsets[2]);
  object.carePruning = reader.readStringOrNull(offsets[3]);
  object.careSoil = reader.readStringOrNull(offsets[4]);
  object.commonName = reader.readString(offsets[5]);
  object.description = reader.readStringOrNull(offsets[6]);
  object.directSunTolerance = reader.readBool(offsets[7]);
  object.droughtTolerant = reader.readBool(offsets[8]);
  object.family = reader.readStringOrNull(offsets[9]);
  object.funFacts = reader.readStringList(offsets[10]) ?? [];
  object.humidityRequirement = reader.readString(offsets[11]);
  object.id = id;
  object.imageUrl = reader.readStringOrNull(offsets[12]);
  object.lightLuxMax = reader.readLongOrNull(offsets[13]);
  object.lightLuxMin = reader.readLongOrNull(offsets[14]);
  object.lightMmolMax = reader.readLongOrNull(offsets[15]);
  object.lightMmolMin = reader.readLongOrNull(offsets[16]);
  object.lightRequirement = reader.readString(offsets[17]);
  object.needsMisting = reader.readBool(offsets[18]);
  object.origin = reader.readStringOrNull(offsets[19]);
  object.propagationMethods = reader.readStringList(offsets[20]) ?? [];
  object.scientificName = reader.readString(offsets[21]);
  object.soilEcMax = reader.readLongOrNull(offsets[22]);
  object.soilEcMin = reader.readLongOrNull(offsets[23]);
  object.soilMoistMax = reader.readLongOrNull(offsets[24]);
  object.soilMoistMin = reader.readLongOrNull(offsets[25]);
  object.temperatureMax = reader.readLongOrNull(offsets[26]);
  object.temperatureMin = reader.readLongOrNull(offsets[27]);
  object.thumbnailUrl = reader.readStringOrNull(offsets[28]);
  object.ttlDays = reader.readLong(offsets[29]);
  object.wateringFrequencyDays = reader.readLong(offsets[30]);
  return object;
}

P _speciesCacheCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringList(offset) ?? []) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringList(offset) ?? []) as P;
    case 21:
      return (reader.readString(offset)) as P;
    case 22:
      return (reader.readLongOrNull(offset)) as P;
    case 23:
      return (reader.readLongOrNull(offset)) as P;
    case 24:
      return (reader.readLongOrNull(offset)) as P;
    case 25:
      return (reader.readLongOrNull(offset)) as P;
    case 26:
      return (reader.readLongOrNull(offset)) as P;
    case 27:
      return (reader.readLongOrNull(offset)) as P;
    case 28:
      return (reader.readStringOrNull(offset)) as P;
    case 29:
      return (reader.readLong(offset)) as P;
    case 30:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _speciesCacheCollectionGetId(SpeciesCacheCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _speciesCacheCollectionGetLinks(
    SpeciesCacheCollection object) {
  return [];
}

void _speciesCacheCollectionAttach(
    IsarCollection<dynamic> col, Id id, SpeciesCacheCollection object) {
  object.id = id;
}

extension SpeciesCacheCollectionByIndex
    on IsarCollection<SpeciesCacheCollection> {
  Future<SpeciesCacheCollection?> getByApiId(String apiId) {
    return getByIndex(r'apiId', [apiId]);
  }

  SpeciesCacheCollection? getByApiIdSync(String apiId) {
    return getByIndexSync(r'apiId', [apiId]);
  }

  Future<bool> deleteByApiId(String apiId) {
    return deleteByIndex(r'apiId', [apiId]);
  }

  bool deleteByApiIdSync(String apiId) {
    return deleteByIndexSync(r'apiId', [apiId]);
  }

  Future<List<SpeciesCacheCollection?>> getAllByApiId(
      List<String> apiIdValues) {
    final values = apiIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'apiId', values);
  }

  List<SpeciesCacheCollection?> getAllByApiIdSync(List<String> apiIdValues) {
    final values = apiIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'apiId', values);
  }

  Future<int> deleteAllByApiId(List<String> apiIdValues) {
    final values = apiIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'apiId', values);
  }

  int deleteAllByApiIdSync(List<String> apiIdValues) {
    final values = apiIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'apiId', values);
  }

  Future<Id> putByApiId(SpeciesCacheCollection object) {
    return putByIndex(r'apiId', object);
  }

  Id putByApiIdSync(SpeciesCacheCollection object, {bool saveLinks = true}) {
    return putByIndexSync(r'apiId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByApiId(List<SpeciesCacheCollection> objects) {
    return putAllByIndex(r'apiId', objects);
  }

  List<Id> putAllByApiIdSync(List<SpeciesCacheCollection> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'apiId', objects, saveLinks: saveLinks);
  }
}

extension SpeciesCacheCollectionQueryWhereSort
    on QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QWhere> {
  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SpeciesCacheCollectionQueryWhere on QueryBuilder<
    SpeciesCacheCollection, SpeciesCacheCollection, QWhereClause> {
  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterWhereClause> apiIdEqualTo(String apiId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'apiId',
        value: [apiId],
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterWhereClause> apiIdNotEqualTo(String apiId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'apiId',
              lower: [],
              upper: [apiId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'apiId',
              lower: [apiId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'apiId',
              lower: [apiId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'apiId',
              lower: [],
              upper: [apiId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SpeciesCacheCollectionQueryFilter on QueryBuilder<
    SpeciesCacheCollection, SpeciesCacheCollection, QFilterCondition> {
  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> apiIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> apiIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> apiIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> apiIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apiId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> apiIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'apiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> apiIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'apiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      apiIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'apiId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      apiIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'apiId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> apiIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> apiIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'apiId',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> cachedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> cachedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> cachedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cachedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> cachedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cachedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'careFertilization',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'careFertilization',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'careFertilization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'careFertilization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'careFertilization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'careFertilization',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'careFertilization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'careFertilization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      careFertilizationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'careFertilization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      careFertilizationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'careFertilization',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'careFertilization',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careFertilizationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'careFertilization',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'carePruning',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'carePruning',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carePruning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'carePruning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'carePruning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'carePruning',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'carePruning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'carePruning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      carePruningContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'carePruning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      carePruningMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'carePruning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'carePruning',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> carePruningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'carePruning',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'careSoil',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'careSoil',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'careSoil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'careSoil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'careSoil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'careSoil',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'careSoil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'careSoil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      careSoilContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'careSoil',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      careSoilMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'careSoil',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'careSoil',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> careSoilIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'careSoil',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> commonNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> commonNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> commonNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> commonNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commonName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> commonNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> commonNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      commonNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commonName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      commonNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commonName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> commonNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonName',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> commonNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commonName',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> directSunToleranceEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'directSunTolerance',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> droughtTolerantEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'droughtTolerant',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'family',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'family',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'family',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      familyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'family',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      familyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'family',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'family',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> familyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'family',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'funFacts',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'funFacts',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'funFacts',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'funFacts',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'funFacts',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'funFacts',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      funFactsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'funFacts',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      funFactsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'funFacts',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'funFacts',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'funFacts',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'funFacts',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'funFacts',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'funFacts',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'funFacts',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'funFacts',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> funFactsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'funFacts',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> humidityRequirementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'humidityRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> humidityRequirementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'humidityRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> humidityRequirementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'humidityRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> humidityRequirementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'humidityRequirement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> humidityRequirementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'humidityRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> humidityRequirementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'humidityRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      humidityRequirementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'humidityRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      humidityRequirementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'humidityRequirement',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> humidityRequirementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'humidityRequirement',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> humidityRequirementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'humidityRequirement',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      imageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMaxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lightLuxMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMaxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lightLuxMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMaxEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightLuxMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMaxGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightLuxMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMaxLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightLuxMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMaxBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightLuxMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lightLuxMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lightLuxMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMinEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightLuxMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMinGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightLuxMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMinLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightLuxMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightLuxMinBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightLuxMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMaxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lightMmolMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMaxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lightMmolMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMaxEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightMmolMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMaxGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightMmolMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMaxLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightMmolMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMaxBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightMmolMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lightMmolMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lightMmolMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMinEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightMmolMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMinGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightMmolMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMinLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightMmolMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightMmolMinBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightMmolMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightRequirementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightRequirementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightRequirementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightRequirementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightRequirement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightRequirementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lightRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightRequirementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lightRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      lightRequirementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lightRequirement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      lightRequirementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lightRequirement',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightRequirementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightRequirement',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> lightRequirementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lightRequirement',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> needsMistingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'needsMisting',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'origin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'origin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'origin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      originContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      originMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'origin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'origin',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> originIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'origin',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propagationMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'propagationMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'propagationMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'propagationMethods',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'propagationMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'propagationMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      propagationMethodsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'propagationMethods',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      propagationMethodsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'propagationMethods',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propagationMethods',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'propagationMethods',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'propagationMethods',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'propagationMethods',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'propagationMethods',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'propagationMethods',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'propagationMethods',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> propagationMethodsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'propagationMethods',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> scientificNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> scientificNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> scientificNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> scientificNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scientificName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> scientificNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> scientificNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      scientificNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      scientificNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'scientificName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> scientificNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scientificName',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> scientificNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'scientificName',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMaxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'soilEcMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMaxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'soilEcMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMaxEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilEcMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMaxGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilEcMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMaxLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilEcMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMaxBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilEcMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'soilEcMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'soilEcMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMinEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilEcMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMinGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilEcMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMinLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilEcMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilEcMinBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilEcMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMaxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'soilMoistMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMaxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'soilMoistMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMaxEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilMoistMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMaxGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilMoistMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMaxLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilMoistMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMaxBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilMoistMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'soilMoistMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'soilMoistMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMinEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilMoistMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMinGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilMoistMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMinLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilMoistMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> soilMoistMinBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilMoistMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMaxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'temperatureMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMaxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'temperatureMax',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMaxEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temperatureMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMaxGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temperatureMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMaxLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temperatureMax',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMaxBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temperatureMax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'temperatureMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'temperatureMin',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMinEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temperatureMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMinGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temperatureMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMinLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temperatureMin',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> temperatureMinBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temperatureMin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailUrl',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailUrl',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlEqualTo(
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlGreaterThan(
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlLessThan(
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlBetween(
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlStartsWith(
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlEndsWith(
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

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      thumbnailUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
          QAfterFilterCondition>
      thumbnailUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> thumbnailUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> ttlDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ttlDays',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> ttlDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ttlDays',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> ttlDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ttlDays',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> ttlDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ttlDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> wateringFrequencyDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wateringFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> wateringFrequencyDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wateringFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> wateringFrequencyDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wateringFrequencyDays',
        value: value,
      ));
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection,
      QAfterFilterCondition> wateringFrequencyDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wateringFrequencyDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SpeciesCacheCollectionQueryObject on QueryBuilder<
    SpeciesCacheCollection, SpeciesCacheCollection, QFilterCondition> {}

extension SpeciesCacheCollectionQueryLinks on QueryBuilder<
    SpeciesCacheCollection, SpeciesCacheCollection, QFilterCondition> {}

extension SpeciesCacheCollectionQuerySortBy
    on QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QSortBy> {
  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiId', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiId', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCareFertilization() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careFertilization', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCareFertilizationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careFertilization', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCarePruning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carePruning', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCarePruningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carePruning', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCareSoil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careSoil', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCareSoilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careSoil', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCommonName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonName', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByCommonNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonName', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByDirectSunTolerance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'directSunTolerance', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByDirectSunToleranceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'directSunTolerance', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByDroughtTolerant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'droughtTolerant', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByDroughtTolerantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'droughtTolerant', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByHumidityRequirement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidityRequirement', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByHumidityRequirementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidityRequirement', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightLuxMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightLuxMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightLuxMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightLuxMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightLuxMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightLuxMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightLuxMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightLuxMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightMmolMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightMmolMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightMmolMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightMmolMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightMmolMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightMmolMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightMmolMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightMmolMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightRequirement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightRequirement', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByLightRequirementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightRequirement', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByNeedsMisting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsMisting', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByNeedsMistingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsMisting', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByOrigin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByOriginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortBySoilEcMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilEcMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortBySoilEcMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilEcMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortBySoilEcMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilEcMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortBySoilEcMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilEcMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortBySoilMoistMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortBySoilMoistMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortBySoilMoistMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortBySoilMoistMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByTemperatureMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByTemperatureMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByTemperatureMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByTemperatureMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByThumbnailUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByThumbnailUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByTtlDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttlDays', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByTtlDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttlDays', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByWateringFrequencyDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringFrequencyDays', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      sortByWateringFrequencyDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringFrequencyDays', Sort.desc);
    });
  }
}

extension SpeciesCacheCollectionQuerySortThenBy on QueryBuilder<
    SpeciesCacheCollection, SpeciesCacheCollection, QSortThenBy> {
  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByApiId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiId', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByApiIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiId', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCachedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cachedAt', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCareFertilization() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careFertilization', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCareFertilizationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careFertilization', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCarePruning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carePruning', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCarePruningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carePruning', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCareSoil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careSoil', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCareSoilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careSoil', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCommonName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonName', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByCommonNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonName', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByDirectSunTolerance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'directSunTolerance', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByDirectSunToleranceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'directSunTolerance', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByDroughtTolerant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'droughtTolerant', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByDroughtTolerantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'droughtTolerant', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByFamily() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByFamilyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'family', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByHumidityRequirement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidityRequirement', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByHumidityRequirementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidityRequirement', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightLuxMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightLuxMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightLuxMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightLuxMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightLuxMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightLuxMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightLuxMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightLuxMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightMmolMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightMmolMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightMmolMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightMmolMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightMmolMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightMmolMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightMmolMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightMmolMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightRequirement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightRequirement', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByLightRequirementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightRequirement', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByNeedsMisting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsMisting', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByNeedsMistingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'needsMisting', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByOrigin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByOriginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenBySoilEcMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilEcMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenBySoilEcMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilEcMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenBySoilEcMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilEcMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenBySoilEcMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilEcMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenBySoilMoistMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenBySoilMoistMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenBySoilMoistMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenBySoilMoistMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByTemperatureMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureMax', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByTemperatureMaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureMax', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByTemperatureMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureMin', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByTemperatureMinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureMin', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByThumbnailUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByThumbnailUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailUrl', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByTtlDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttlDays', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByTtlDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttlDays', Sort.desc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByWateringFrequencyDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringFrequencyDays', Sort.asc);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QAfterSortBy>
      thenByWateringFrequencyDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringFrequencyDays', Sort.desc);
    });
  }
}

extension SpeciesCacheCollectionQueryWhereDistinct
    on QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct> {
  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByApiId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apiId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByCachedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cachedAt');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByCareFertilization({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'careFertilization',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByCarePruning({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carePruning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByCareSoil({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'careSoil', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByCommonName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commonName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByDirectSunTolerance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'directSunTolerance');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByDroughtTolerant() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'droughtTolerant');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByFamily({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'family', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByFunFacts() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'funFacts');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByHumidityRequirement({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'humidityRequirement',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByImageUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByLightLuxMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightLuxMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByLightLuxMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightLuxMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByLightMmolMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightMmolMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByLightMmolMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightMmolMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByLightRequirement({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightRequirement',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByNeedsMisting() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'needsMisting');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByOrigin({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'origin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByPropagationMethods() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propagationMethods');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByScientificName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scientificName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctBySoilEcMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilEcMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctBySoilEcMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilEcMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctBySoilMoistMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilMoistMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctBySoilMoistMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilMoistMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByTemperatureMax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temperatureMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByTemperatureMin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temperatureMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByThumbnailUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbnailUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByTtlDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ttlDays');
    });
  }

  QueryBuilder<SpeciesCacheCollection, SpeciesCacheCollection, QDistinct>
      distinctByWateringFrequencyDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wateringFrequencyDays');
    });
  }
}

extension SpeciesCacheCollectionQueryProperty on QueryBuilder<
    SpeciesCacheCollection, SpeciesCacheCollection, QQueryProperty> {
  QueryBuilder<SpeciesCacheCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String, QQueryOperations>
      apiIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apiId');
    });
  }

  QueryBuilder<SpeciesCacheCollection, DateTime, QQueryOperations>
      cachedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cachedAt');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String?, QQueryOperations>
      careFertilizationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'careFertilization');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String?, QQueryOperations>
      carePruningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carePruning');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String?, QQueryOperations>
      careSoilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'careSoil');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String, QQueryOperations>
      commonNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commonName');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<SpeciesCacheCollection, bool, QQueryOperations>
      directSunToleranceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'directSunTolerance');
    });
  }

  QueryBuilder<SpeciesCacheCollection, bool, QQueryOperations>
      droughtTolerantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'droughtTolerant');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String?, QQueryOperations>
      familyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'family');
    });
  }

  QueryBuilder<SpeciesCacheCollection, List<String>, QQueryOperations>
      funFactsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'funFacts');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String, QQueryOperations>
      humidityRequirementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'humidityRequirement');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String?, QQueryOperations>
      imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      lightLuxMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightLuxMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      lightLuxMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightLuxMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      lightMmolMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightMmolMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      lightMmolMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightMmolMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String, QQueryOperations>
      lightRequirementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightRequirement');
    });
  }

  QueryBuilder<SpeciesCacheCollection, bool, QQueryOperations>
      needsMistingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'needsMisting');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String?, QQueryOperations>
      originProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'origin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, List<String>, QQueryOperations>
      propagationMethodsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propagationMethods');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String, QQueryOperations>
      scientificNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scientificName');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      soilEcMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilEcMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      soilEcMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilEcMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      soilMoistMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilMoistMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      soilMoistMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilMoistMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      temperatureMaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temperatureMax');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int?, QQueryOperations>
      temperatureMinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temperatureMin');
    });
  }

  QueryBuilder<SpeciesCacheCollection, String?, QQueryOperations>
      thumbnailUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnailUrl');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int, QQueryOperations>
      ttlDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ttlDays');
    });
  }

  QueryBuilder<SpeciesCacheCollection, int, QQueryOperations>
      wateringFrequencyDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wateringFrequencyDays');
    });
  }
}
