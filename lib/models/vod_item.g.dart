// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vod_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVodItemCollection on Isar {
  IsarCollection<VodItem> get vodItems => this.collection();
}

const VodItemSchema = CollectionSchema(
  name: r'VodItem',
  id: 696518392691501252,
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
    r'containerExtension': PropertySchema(
      id: 3,
      name: r'containerExtension',
      type: IsarType.string,
    ),
    r'director': PropertySchema(
      id: 4,
      name: r'director',
      type: IsarType.string,
    ),
    r'genre': PropertySchema(
      id: 5,
      name: r'genre',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 6,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'plot': PropertySchema(
      id: 8,
      name: r'plot',
      type: IsarType.string,
    ),
    r'rating': PropertySchema(
      id: 9,
      name: r'rating',
      type: IsarType.double,
    ),
    r'releaseDate': PropertySchema(
      id: 10,
      name: r'releaseDate',
      type: IsarType.dateTime,
    ),
    r'streamIcon': PropertySchema(
      id: 11,
      name: r'streamIcon',
      type: IsarType.string,
    ),
    r'streamId': PropertySchema(
      id: 12,
      name: r'streamId',
      type: IsarType.long,
    )
  },
  estimateSize: _vodItemEstimateSize,
  serialize: _vodItemSerialize,
  deserialize: _vodItemDeserialize,
  deserializeProp: _vodItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'streamId': IndexSchema(
      id: -2308752684150834108,
      name: r'streamId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'streamId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _vodItemGetId,
  getLinks: _vodItemGetLinks,
  attach: _vodItemAttach,
  version: '3.1.0+1',
);

int _vodItemEstimateSize(
  VodItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cast.length * 3;
  bytesCount += 3 + object.containerExtension.length * 3;
  bytesCount += 3 + object.director.length * 3;
  bytesCount += 3 + object.genre.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.plot.length * 3;
  bytesCount += 3 + object.streamIcon.length * 3;
  return bytesCount;
}

void _vodItemSerialize(
  VodItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.cacheExpiry);
  writer.writeString(offsets[1], object.cast);
  writer.writeLong(offsets[2], object.categoryId);
  writer.writeString(offsets[3], object.containerExtension);
  writer.writeString(offsets[4], object.director);
  writer.writeString(offsets[5], object.genre);
  writer.writeLong(offsets[6], object.hashCode);
  writer.writeString(offsets[7], object.name);
  writer.writeString(offsets[8], object.plot);
  writer.writeDouble(offsets[9], object.rating);
  writer.writeDateTime(offsets[10], object.releaseDate);
  writer.writeString(offsets[11], object.streamIcon);
  writer.writeLong(offsets[12], object.streamId);
}

VodItem _vodItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VodItem(
    cacheExpiry: reader.readDateTime(offsets[0]),
    cast: reader.readString(offsets[1]),
    categoryId: reader.readLong(offsets[2]),
    containerExtension: reader.readString(offsets[3]),
    director: reader.readString(offsets[4]),
    genre: reader.readString(offsets[5]),
    name: reader.readString(offsets[7]),
    plot: reader.readString(offsets[8]),
    rating: reader.readDouble(offsets[9]),
    releaseDate: reader.readDateTimeOrNull(offsets[10]),
    streamIcon: reader.readString(offsets[11]),
    streamId: reader.readLong(offsets[12]),
  );
  object.id = id;
  return object;
}

P _vodItemDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vodItemGetId(VodItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vodItemGetLinks(VodItem object) {
  return [];
}

void _vodItemAttach(IsarCollection<dynamic> col, Id id, VodItem object) {
  object.id = id;
}

extension VodItemQueryWhereSort on QueryBuilder<VodItem, VodItem, QWhere> {
  QueryBuilder<VodItem, VodItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterWhere> anyStreamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'streamId'),
      );
    });
  }
}

extension VodItemQueryWhere on QueryBuilder<VodItem, VodItem, QWhereClause> {
  QueryBuilder<VodItem, VodItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> idBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> streamIdEqualTo(
      int streamId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'streamId',
        value: [streamId],
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> streamIdNotEqualTo(
      int streamId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'streamId',
              lower: [],
              upper: [streamId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'streamId',
              lower: [streamId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'streamId',
              lower: [streamId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'streamId',
              lower: [],
              upper: [streamId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> streamIdGreaterThan(
    int streamId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'streamId',
        lower: [streamId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> streamIdLessThan(
    int streamId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'streamId',
        lower: [],
        upper: [streamId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterWhereClause> streamIdBetween(
    int lowerStreamId,
    int upperStreamId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'streamId',
        lower: [lowerStreamId],
        includeLower: includeLower,
        upper: [upperStreamId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VodItemQueryFilter
    on QueryBuilder<VodItem, VodItem, QFilterCondition> {
  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> cacheExpiryEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cacheExpiry',
        value: value,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> cacheExpiryGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> cacheExpiryLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> cacheExpiryBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castEqualTo(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castStartsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castEndsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castContains(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castMatches(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cast',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> castIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cast',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> categoryIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> categoryIdGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> categoryIdLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> categoryIdBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'containerExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'containerExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'containerExtension',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'containerExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'containerExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'containerExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'containerExtension',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerExtension',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition>
      containerExtensionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'containerExtension',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorEqualTo(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorStartsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorEndsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorContains(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorMatches(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'director',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> directorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'director',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreEqualTo(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreStartsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreEndsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreContains(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreMatches(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'genre',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> genreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'genre',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> hashCodeGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameContains(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotEqualTo(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotStartsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotEndsWith(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotContains(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotMatches(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plot',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> plotIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plot',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> ratingEqualTo(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> ratingGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> ratingLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> ratingBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> releaseDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'releaseDate',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> releaseDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'releaseDate',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> releaseDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'releaseDate',
        value: value,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> releaseDateGreaterThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> releaseDateLessThan(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> releaseDateBetween(
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

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamIcon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streamIcon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streamIcon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streamIcon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'streamIcon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'streamIcon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'streamIcon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'streamIcon',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamIcon',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIconIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'streamIcon',
        value: '',
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamId',
        value: value,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streamId',
        value: value,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streamId',
        value: value,
      ));
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterFilterCondition> streamIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streamId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VodItemQueryObject
    on QueryBuilder<VodItem, VodItem, QFilterCondition> {}

extension VodItemQueryLinks
    on QueryBuilder<VodItem, VodItem, QFilterCondition> {}

extension VodItemQuerySortBy on QueryBuilder<VodItem, VodItem, QSortBy> {
  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByCacheExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByCast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cast', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByCastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cast', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByContainerExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerExtension', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByContainerExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerExtension', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByDirector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'director', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByDirectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'director', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByGenre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByGenreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByPlot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plot', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByPlotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plot', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByStreamIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamIcon', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByStreamIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamIcon', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByStreamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamId', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> sortByStreamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamId', Sort.desc);
    });
  }
}

extension VodItemQuerySortThenBy
    on QueryBuilder<VodItem, VodItem, QSortThenBy> {
  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByCacheExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByCast() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cast', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByCastDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cast', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByContainerExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerExtension', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByContainerExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerExtension', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByDirector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'director', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByDirectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'director', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByGenre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByGenreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'genre', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByPlot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plot', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByPlotDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plot', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rating', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByStreamIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamIcon', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByStreamIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamIcon', Sort.desc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByStreamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamId', Sort.asc);
    });
  }

  QueryBuilder<VodItem, VodItem, QAfterSortBy> thenByStreamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamId', Sort.desc);
    });
  }
}

extension VodItemQueryWhereDistinct
    on QueryBuilder<VodItem, VodItem, QDistinct> {
  QueryBuilder<VodItem, VodItem, QDistinct> distinctByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cacheExpiry');
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByCast(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cast', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByContainerExtension(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'containerExtension',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByDirector(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'director', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByGenre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'genre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByPlot(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plot', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rating');
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'releaseDate');
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByStreamIcon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streamIcon', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VodItem, VodItem, QDistinct> distinctByStreamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streamId');
    });
  }
}

extension VodItemQueryProperty
    on QueryBuilder<VodItem, VodItem, QQueryProperty> {
  QueryBuilder<VodItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VodItem, DateTime, QQueryOperations> cacheExpiryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheExpiry');
    });
  }

  QueryBuilder<VodItem, String, QQueryOperations> castProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cast');
    });
  }

  QueryBuilder<VodItem, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<VodItem, String, QQueryOperations> containerExtensionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'containerExtension');
    });
  }

  QueryBuilder<VodItem, String, QQueryOperations> directorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'director');
    });
  }

  QueryBuilder<VodItem, String, QQueryOperations> genreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genre');
    });
  }

  QueryBuilder<VodItem, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<VodItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<VodItem, String, QQueryOperations> plotProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plot');
    });
  }

  QueryBuilder<VodItem, double, QQueryOperations> ratingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rating');
    });
  }

  QueryBuilder<VodItem, DateTime?, QQueryOperations> releaseDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'releaseDate');
    });
  }

  QueryBuilder<VodItem, String, QQueryOperations> streamIconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streamIcon');
    });
  }

  QueryBuilder<VodItem, int, QQueryOperations> streamIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streamId');
    });
  }
}
