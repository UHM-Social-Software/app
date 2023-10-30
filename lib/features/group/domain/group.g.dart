// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      upcomingEvents: json['upcomingEvents'] as String,
      imagePath: json['imagePath'] as String?,
      owner: json['owner'] as String,
      membership: (json['membership'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'upcomingEvents': instance.upcomingEvents,
      'imagePath': instance.imagePath,
      'owner': instance.owner,
      'membership': instance.membership,
    };
