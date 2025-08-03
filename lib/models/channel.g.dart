// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChannelCollection on Isar {
  IsarCollection<Channel> get channels => this.collection();
}

const ChannelSchema = CollectionSchema(
  name: r'Channel',
  id: 3096422491918372507,
  properties: {
    r'addedOn': PropertySchema(
      id: 0,
      name: r'addedOn',
      type: IsarType.dateTime,
    ),
    r'cacheExpiry': PropertySchema(
      id: 1,
      name: r'cacheExpiry',
      type: IsarType.dateTime,
    ),
    r'categoryId': PropertySchema(
      id: 2,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'created': PropertySchema(
      id: 3,
      name: r'created',
      type: IsarType.dateTime,
    ),
    r'hasArchive': PropertySchema(
      id: 4,
      name: r'hasArchive',
      type: IsarType.bool,
    ),
    r'hashCode': PropertySchema(
      id: 5,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'streamIcon': PropertySchema(
      id: 7,
      name: r'streamIcon',
      type: IsarType.string,
    ),
    r'streamId': PropertySchema(
      id: 8,
      name: r'streamId',
      type: IsarType.long,
    ),
    r'streamType': PropertySchema(
      id: 9,
      name: r'streamType',
      type: IsarType.string,
    )
  },
  estimateSize: _channelEstimateSize,
  serialize: _channelSerialize,
  deserialize: _channelDeserialize,
  deserializeProp: _channelDeserializeProp,
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
  getId: _channelGetId,
  getLinks: _channelGetLinks,
  attach: _channelAttach,
  version: '3.1.0+1',
);

int _channelEstimateSize(
  Channel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.streamIcon.length * 3;
  bytesCount += 3 + object.streamType.length * 3;
  return bytesCount;
}

void _channelSerialize(
  Channel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.addedOn);
  writer.writeDateTime(offsets[1], object.cacheExpiry);
  writer.writeLong(offsets[2], object.categoryId);
  writer.writeDateTime(offsets[3], object.created);
  writer.writeBool(offsets[4], object.hasArchive);
  writer.writeLong(offsets[5], object.hashCode);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.streamIcon);
  writer.writeLong(offsets[8], object.streamId);
  writer.writeString(offsets[9], object.streamType);
}

Channel _channelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Channel(
    addedOn: reader.readDateTimeOrNull(offsets[0]),
    cacheExpiry: reader.readDateTime(offsets[1]),
    categoryId: reader.readLong(offsets[2]),
    created: reader.readDateTimeOrNull(offsets[3]),
    hasArchive: reader.readBoolOrNull(offsets[4]) ?? false,
    name: reader.readString(offsets[6]),
    streamIcon: reader.readString(offsets[7]),
    streamId: reader.readLong(offsets[8]),
    streamType: reader.readString(offsets[9]),
  );
  object.id = id;
  return object;
}

P _channelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readLong(offset)) as P;
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

Id _channelGetId(Channel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _channelGetLinks(Channel object) {
  return [];
}

void _channelAttach(IsarCollection<dynamic> col, Id id, Channel object) {
  object.id = id;
}

extension ChannelQueryWhereSort on QueryBuilder<Channel, Channel, QWhere> {
  QueryBuilder<Channel, Channel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Channel, Channel, QAfterWhere> anyStreamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'streamId'),
      );
    });
  }
}

extension ChannelQueryWhere on QueryBuilder<Channel, Channel, QWhereClause> {
  QueryBuilder<Channel, Channel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Channel, Channel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Channel, Channel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Channel, Channel, QAfterWhereClause> idBetween(
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

  QueryBuilder<Channel, Channel, QAfterWhereClause> streamIdEqualTo(
      int streamId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'streamId',
        value: [streamId],
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterWhereClause> streamIdNotEqualTo(
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

  QueryBuilder<Channel, Channel, QAfterWhereClause> streamIdGreaterThan(
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

  QueryBuilder<Channel, Channel, QAfterWhereClause> streamIdLessThan(
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

  QueryBuilder<Channel, Channel, QAfterWhereClause> streamIdBetween(
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

extension ChannelQueryFilter
    on QueryBuilder<Channel, Channel, QFilterCondition> {
  QueryBuilder<Channel, Channel, QAfterFilterCondition> addedOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'addedOn',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> addedOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'addedOn',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> addedOnEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'addedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> addedOnGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'addedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> addedOnLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'addedOn',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> addedOnBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'addedOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> cacheExpiryEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cacheExpiry',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> cacheExpiryGreaterThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> cacheExpiryLessThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> cacheExpiryBetween(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> categoryIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> categoryIdGreaterThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> categoryIdLessThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> categoryIdBetween(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> createdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'created',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> createdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'created',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> createdEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> createdGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> createdLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> createdBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'created',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> hasArchiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasArchive',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> hashCodeGreaterThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconEqualTo(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconGreaterThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconLessThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconBetween(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconStartsWith(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconEndsWith(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconContains(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconMatches(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamIcon',
        value: '',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIconIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'streamIcon',
        value: '',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamId',
        value: value,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIdGreaterThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIdLessThan(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamIdBetween(
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

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streamType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streamType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streamType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'streamType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'streamType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'streamType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'streamType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streamType',
        value: '',
      ));
    });
  }

  QueryBuilder<Channel, Channel, QAfterFilterCondition> streamTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'streamType',
        value: '',
      ));
    });
  }
}

extension ChannelQueryObject
    on QueryBuilder<Channel, Channel, QFilterCondition> {}

extension ChannelQueryLinks
    on QueryBuilder<Channel, Channel, QFilterCondition> {}

extension ChannelQuerySortBy on QueryBuilder<Channel, Channel, QSortBy> {
  QueryBuilder<Channel, Channel, QAfterSortBy> sortByAddedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedOn', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByAddedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedOn', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByCacheExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByHasArchive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasArchive', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByHasArchiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasArchive', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByStreamIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamIcon', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByStreamIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamIcon', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByStreamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamId', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByStreamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamId', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByStreamType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamType', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> sortByStreamTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamType', Sort.desc);
    });
  }
}

extension ChannelQuerySortThenBy
    on QueryBuilder<Channel, Channel, QSortThenBy> {
  QueryBuilder<Channel, Channel, QAfterSortBy> thenByAddedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedOn', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByAddedOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'addedOn', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByCacheExpiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheExpiry', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByHasArchive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasArchive', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByHasArchiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasArchive', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByStreamIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamIcon', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByStreamIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamIcon', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByStreamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamId', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByStreamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamId', Sort.desc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByStreamType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamType', Sort.asc);
    });
  }

  QueryBuilder<Channel, Channel, QAfterSortBy> thenByStreamTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streamType', Sort.desc);
    });
  }
}

extension ChannelQueryWhereDistinct
    on QueryBuilder<Channel, Channel, QDistinct> {
  QueryBuilder<Channel, Channel, QDistinct> distinctByAddedOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'addedOn');
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByCacheExpiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cacheExpiry');
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created');
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByHasArchive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasArchive');
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByStreamIcon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streamIcon', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByStreamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streamId');
    });
  }

  QueryBuilder<Channel, Channel, QDistinct> distinctByStreamType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streamType', caseSensitive: caseSensitive);
    });
  }
}

extension ChannelQueryProperty
    on QueryBuilder<Channel, Channel, QQueryProperty> {
  QueryBuilder<Channel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Channel, DateTime?, QQueryOperations> addedOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'addedOn');
    });
  }

  QueryBuilder<Channel, DateTime, QQueryOperations> cacheExpiryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheExpiry');
    });
  }

  QueryBuilder<Channel, int, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<Channel, DateTime?, QQueryOperations> createdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created');
    });
  }

  QueryBuilder<Channel, bool, QQueryOperations> hasArchiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasArchive');
    });
  }

  QueryBuilder<Channel, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<Channel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Channel, String, QQueryOperations> streamIconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streamIcon');
    });
  }

  QueryBuilder<Channel, int, QQueryOperations> streamIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streamId');
    });
  }

  QueryBuilder<Channel, String, QQueryOperations> streamTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streamType');
    });
  }
}
