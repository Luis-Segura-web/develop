// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSeriesItemCollection on Isar {
  IsarCollection<SeriesItem> get seriesItems => this.collection();
}

const SeriesItemSchema = CollectionSchema(
  name: r'SeriesItem',
  id: 8062651440113474391,
  properties: {
    r'cacheExpiry': PropertySchema(
      id: 0,
      name: r'cacheExpiry',
      type: IsarType.dateTime,
    ),
    r'cast': PropertySchema(
      id: 1,
      name: r'cast',
      type: IsarType.string,
    ),
    r'categoryId': PropertySchema(
      id: 2,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'cover': PropertySchema(
      id: 3,
      name: r'cover',
      type: IsarType.string,
    ),
    r'director': PropertySchema(
      id: 4,
      name: r'director',
      type: IsarType.string,
    ),
    r'episodeRunTime': PropertySchema(
      id: 5,
      name: r'episodeRunTime',
      type: IsarType.long,
    ),
    r'genre': PropertySchema(
      id: 6,
      name: r'genre',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 7,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'plot': PropertySchema(
      id: 9,
      name: r'plot',
      type: IsarType.string,
    ),
    r'rating': PropertySchema(
      id: 10,
      name: r'rating',
      type: IsarType.double,
    ),
    r'releaseDate': PropertySchema(
      id: 11,
      name: r'releaseDate',
      type: IsarType.dateTime,
    ),
    r'seriesId': PropertySchema(
      id: 12,
      name: r'seriesId',
      type: IsarType.long,
    )
  },
  estimateSize: _seriesItemEstimateSize,
  serialize: _seriesItemSerialize,
  deserialize: _seriesItemDeserialize,
  deserializeProp: _seriesItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'seriesId': IndexSchema(
      id: -6366517829284187702,
      name: r'seriesId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'seriesId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _seriesItemGetId,
  getLinks: _seriesItemGetLinks,
  attach: _seriesItemAttach,
  version: '3.1.0+1',
);

int _seriesItemEstimateSize(
  SeriesItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cast.length * 3;
  bytesCount += 3 + object.cover.length * 3;
  bytesCount += 3 + object.director.length * 3;
  bytesCount += 3 + object.genre.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.plot.length * 3;
  return bytesCount;
}

void _seriesItemSerialize(
  SeriesItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.cacheExpiry);
  writer.writeString(offsets[1], object.cast);
  writer.writeLong(offsets[2], object.categoryId);
  writer.writeString(offsets[3], object.cover);
  writer.writeString(offsets[4], object.director);
  writer.writeLong(offsets[5], object.episodeRunTime);
  writer.writeString(offsets[6], object.genre);
  writer.writeLong(offsets[7], object.hashCode);
  writer.writeString(offsets[8], object.name);
  writer.writeString(offsets[9], object.plot);
  writer.writeDouble(offsets[10], object.rating);
  writer.writeDateTime(offsets[11], object.releaseDate);
  writer.writeLong(offsets[12], object.seriesId);
}

SeriesItem _seriesItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SeriesItem(
    cacheExpiry: reader.readDateTime(offsets[0]),
    cast: reader.readString(offsets[1]),
    categoryId: reader.readLong(offsets[2]),
    cover: reader.readString(offsets[3]),
    director: reader.readString(offsets[4]),
    episodeRunTime: reader.readLong(offsets[5]),
    genre: reader.readString(offsets[6]),
    name: reader.readString(offsets[8]),
    plot: reader.readString(offsets[9]),
    rating: reader.readDouble(offsets[10]),
    releaseDate: reader.readDateTimeOrNull(offsets[11]),
    seriesId: reader.readLong(offsets[12]),
  );
  object.id = id;
  return object;
}

P _seriesItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _seriesItemGetId(SeriesItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _seriesItemGetLinks(SeriesItem object) {
  return [];
}

void _seriesItemAttach(IsarCollection<dynamic> col, Id id, SeriesItem object) {
  object.id = id;
}

extension SeriesItemQueryWhereSort
    on QueryBuilder<SeriesItem, SeriesItem, QWhere> {
  QueryBuilder<SeriesItem, SeriesItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhere> anySeriesId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'seriesId'),
      );
    });
  }
}

extension SeriesItemQueryWhere
    on QueryBuilder<SeriesItem, SeriesItem, QWhereClause> {
  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> idBetween(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> seriesIdEqualTo(
      int seriesId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'seriesId',
        value: [seriesId],
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> seriesIdNotEqualTo(
      int seriesId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seriesId',
              lower: [],
              upper: [seriesId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seriesId',
              lower: [seriesId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seriesId',
              lower: [seriesId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'seriesId',
              lower: [],
              upper: [seriesId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> seriesIdGreaterThan(
    int seriesId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'seriesId',
        lower: [seriesId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> seriesIdLessThan(
    int seriesId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'seriesId',
        lower: [],
        upper: [seriesId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterWhereClause> seriesIdBetween(
    int lowerSeriesId,
    int upperSeriesId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'seriesId',
        lower: [lowerSeriesId],
        includeLower: includeLower,
        upper: [upperSeriesId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SeriesItemQueryFilter
    on QueryBuilder<SeriesItem, SeriesItem, QFilterCondition> {
  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      cacheExpiryEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cacheExpiry',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      cacheExpiryLessThan(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      cacheExpiryBetween(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cast',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cast',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cast',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cast',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cast',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cast',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cast',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cast',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cast',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> castIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cast',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> categoryIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      categoryIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      categoryIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> categoryIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cover',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cover',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> coverIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cover',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      coverIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cover',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> directorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'director',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      directorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'director',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> directorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'director',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> directorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'director',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      directorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'director',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> directorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'director',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> directorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'director',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> directorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'director',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      directorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'director',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      directorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'director',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      episodeRunTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodeRunTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      episodeRunTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodeRunTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      episodeRunTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodeRunTime',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      episodeRunTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodeRunTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'genre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'genre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'genre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> genreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genre',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      genreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'genre',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      hashCodeGreaterThan(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plot',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plot',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plot',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plot',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plot',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plot',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plot',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plot',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plot',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> plotIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plot',
        value: '',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> ratingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> ratingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> ratingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> ratingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      releaseDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'releaseDate',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      releaseDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'releaseDate',
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      releaseDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'releaseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      releaseDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'releaseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      releaseDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'releaseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      releaseDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'releaseDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> seriesIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seriesId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition>
      seriesIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seriesId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> seriesIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seriesId',
        value: value,
      ));
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterFilterCondition> seriesIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seriesId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SeriesItemQueryObject
    on QueryBuilder<SeriesItem, SeriesItem, QFilterCondition> {}

extension SeriesItemQueryLinks
    on QueryBuilder<SeriesItem, SeriesItem, QFilterCondition> {}

extension SeriesItemQuerySortBy
    on QueryBuilder<SeriesItem, SeriesItem, QSortBy> {
  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByCacheExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByCast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cast', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByCastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cast', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByDirector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'director', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByDirectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'director', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByEpisodeRunTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeRunTime', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy>
      sortByEpisodeRunTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeRunTime', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByGenre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByGenreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByPlot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plot', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByPlotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plot', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortBySeriesId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesId', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> sortBySeriesIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesId', Sort.desc);
    });
  }
}

extension SeriesItemQuerySortThenBy
    on QueryBuilder<SeriesItem, SeriesItem, QSortThenBy> {
  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByCacheExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByCast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cast', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByCastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cast', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByDirector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'director', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByDirectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'director', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByEpisodeRunTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeRunTime', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy>
      thenByEpisodeRunTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeRunTime', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByGenre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByGenreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByPlot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plot', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByPlotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plot', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenBySeriesId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesId', Sort.asc);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QAfterSortBy> thenBySeriesIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seriesId', Sort.desc);
    });
  }
}

extension SeriesItemQueryWhereDistinct
    on QueryBuilder<SeriesItem, SeriesItem, QDistinct> {
  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cacheExpiry');
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByCast(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cast', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByCover(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cover', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByDirector(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'director', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByEpisodeRunTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodeRunTime');
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByGenre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByPlot(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plot', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'releaseDate');
    });
  }

  QueryBuilder<SeriesItem, SeriesItem, QDistinct> distinctBySeriesId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seriesId');
    });
  }
}

extension SeriesItemQueryProperty
    on QueryBuilder<SeriesItem, SeriesItem, QQueryProperty> {
  QueryBuilder<SeriesItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SeriesItem, DateTime, QQueryOperations> cacheExpiryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheExpiry');
    });
  }

  QueryBuilder<SeriesItem, String, QQueryOperations> castProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cast');
    });
  }

  QueryBuilder<SeriesItem, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<SeriesItem, String, QQueryOperations> coverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cover');
    });
  }

  QueryBuilder<SeriesItem, String, QQueryOperations> directorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'director');
    });
  }

  QueryBuilder<SeriesItem, int, QQueryOperations> episodeRunTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodeRunTime');
    });
  }

  QueryBuilder<SeriesItem, String, QQueryOperations> genreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genre');
    });
  }

  QueryBuilder<SeriesItem, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<SeriesItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SeriesItem, String, QQueryOperations> plotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plot');
    });
  }

  QueryBuilder<SeriesItem, double, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<SeriesItem, DateTime?, QQueryOperations> releaseDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'releaseDate');
    });
  }

  QueryBuilder<SeriesItem, int, QQueryOperations> seriesIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seriesId');
    });
  }
}
