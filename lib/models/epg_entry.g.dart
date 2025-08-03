// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epg_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEpgEntryCollection on Isar {
  IsarCollection<EpgEntry> get epgEntrys => this.collection();
}

const EpgEntrySchema = CollectionSchema(
  name: r'EpgEntry',
  id: -8325955376096495073,
  properties: {
    r'cacheExpiry': PropertySchema(
      id: 0,
      name: r'cacheExpiry',
      type: IsarType.dateTime,
    ),
    r'channelId': PropertySchema(
      id: 1,
      name: r'channelId',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'durationInMinutes': PropertySchema(
      id: 3,
      name: r'durationInMinutes',
      type: IsarType.long,
    ),
    r'endTime': PropertySchema(
      id: 4,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'hashCode': PropertySchema(
      id: 5,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'isLive': PropertySchema(
      id: 6,
      name: r'isLive',
      type: IsarType.bool,
    ),
    r'startTime': PropertySchema(
      id: 7,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 8,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _epgEntryEstimateSize,
  serialize: _epgEntrySerialize,
  deserialize: _epgEntryDeserialize,
  deserializeProp: _epgEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'channelId': IndexSchema(
      id: -8352446570702114471,
      name: r'channelId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'channelId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _epgEntryGetId,
  getLinks: _epgEntryGetLinks,
  attach: _epgEntryAttach,
  version: '3.1.0+1',
);

int _epgEntryEstimateSize(
  EpgEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _epgEntrySerialize(
  EpgEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.cacheExpiry);
  writer.writeLong(offsets[1], object.channelId);
  writer.writeString(offsets[2], object.description);
  writer.writeLong(offsets[3], object.durationInMinutes);
  writer.writeDateTime(offsets[4], object.endTime);
  writer.writeLong(offsets[5], object.hashCode);
  writer.writeBool(offsets[6], object.isLive);
  writer.writeDateTime(offsets[7], object.startTime);
  writer.writeString(offsets[8], object.title);
}

EpgEntry _epgEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EpgEntry(
    cacheExpiry: reader.readDateTime(offsets[0]),
    channelId: reader.readLong(offsets[1]),
    description: reader.readString(offsets[2]),
    endTime: reader.readDateTime(offsets[4]),
    startTime: reader.readDateTime(offsets[7]),
    title: reader.readString(offsets[8]),
  );
  object.id = id;
  return object;
}

P _epgEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _epgEntryGetId(EpgEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _epgEntryGetLinks(EpgEntry object) {
  return [];
}

void _epgEntryAttach(IsarCollection<dynamic> col, Id id, EpgEntry object) {
  object.id = id;
}

extension EpgEntryQueryWhereSort on QueryBuilder<EpgEntry, EpgEntry, QWhere> {
  QueryBuilder<EpgEntry, EpgEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhere> anyChannelId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'channelId'),
      );
    });
  }
}

extension EpgEntryQueryWhere on QueryBuilder<EpgEntry, EpgEntry, QWhereClause> {
  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> idBetween(
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> channelIdEqualTo(
      int channelId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'channelId',
        value: [channelId],
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> channelIdNotEqualTo(
      int channelId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelId',
              lower: [],
              upper: [channelId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelId',
              lower: [channelId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelId',
              lower: [channelId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'channelId',
              lower: [],
              upper: [channelId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> channelIdGreaterThan(
    int channelId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelId',
        lower: [channelId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> channelIdLessThan(
    int channelId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelId',
        lower: [],
        upper: [channelId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterWhereClause> channelIdBetween(
    int lowerChannelId,
    int upperChannelId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'channelId',
        lower: [lowerChannelId],
        includeLower: includeLower,
        upper: [upperChannelId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EpgEntryQueryFilter
    on QueryBuilder<EpgEntry, EpgEntry, QFilterCondition> {
  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> cacheExpiryEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cacheExpiry',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition>
      cacheExpiryGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cacheExpiry',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> cacheExpiryLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cacheExpiry',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> cacheExpiryBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cacheExpiry',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> channelIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelId',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> channelIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'channelId',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> channelIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'channelId',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> channelIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'channelId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> descriptionEqualTo(
    String value, {
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> descriptionLessThan(
    String value, {
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition>
      durationInMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition>
      durationInMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition>
      durationInMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationInMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition>
      durationInMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationInMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> endTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> endTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> endTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> endTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> isLiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLive',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> startTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> startTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> startTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension EpgEntryQueryObject
    on QueryBuilder<EpgEntry, EpgEntry, QFilterCondition> {}

extension EpgEntryQueryLinks
    on QueryBuilder<EpgEntry, EpgEntry, QFilterCondition> {}

extension EpgEntryQuerySortBy on QueryBuilder<EpgEntry, EpgEntry, QSortBy> {
  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByCacheExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByChannelId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelId', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByChannelIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelId', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByDurationInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInMinutes', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByDurationInMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInMinutes', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByIsLiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension EpgEntryQuerySortThenBy
    on QueryBuilder<EpgEntry, EpgEntry, QSortThenBy> {
  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByCacheExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByChannelId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelId', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByChannelIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelId', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByDurationInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInMinutes', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByDurationInMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationInMinutes', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByIsLiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension EpgEntryQueryWhereDistinct
    on QueryBuilder<EpgEntry, EpgEntry, QDistinct> {
  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cacheExpiry');
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByChannelId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelId');
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByDurationInMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationInMinutes');
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLive');
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<EpgEntry, EpgEntry, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension EpgEntryQueryProperty
    on QueryBuilder<EpgEntry, EpgEntry, QQueryProperty> {
  QueryBuilder<EpgEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EpgEntry, DateTime, QQueryOperations> cacheExpiryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheExpiry');
    });
  }

  QueryBuilder<EpgEntry, int, QQueryOperations> channelIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelId');
    });
  }

  QueryBuilder<EpgEntry, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<EpgEntry, int, QQueryOperations> durationInMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationInMinutes');
    });
  }

  QueryBuilder<EpgEntry, DateTime, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<EpgEntry, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<EpgEntry, bool, QQueryOperations> isLiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLive');
    });
  }

  QueryBuilder<EpgEntry, DateTime, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<EpgEntry, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
