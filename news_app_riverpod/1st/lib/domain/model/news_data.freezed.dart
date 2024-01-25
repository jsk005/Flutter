// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewsData _$NewsDataFromJson(Map<String, dynamic> json) {
  return _NewsData.fromJson(json);
}

/// @nodoc
mixin _$NewsData {
  String? get title => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get urlToImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsDataCopyWith<NewsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsDataCopyWith<$Res> {
  factory $NewsDataCopyWith(NewsData value, $Res Function(NewsData) then) =
      _$NewsDataCopyWithImpl<$Res, NewsData>;
  @useResult
  $Res call({String? title, String? url, String? urlToImage});
}

/// @nodoc
class _$NewsDataCopyWithImpl<$Res, $Val extends NewsData>
    implements $NewsDataCopyWith<$Res> {
  _$NewsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      urlToImage: freezed == urlToImage
          ? _value.urlToImage
          : urlToImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsDataImplCopyWith<$Res>
    implements $NewsDataCopyWith<$Res> {
  factory _$$NewsDataImplCopyWith(
          _$NewsDataImpl value, $Res Function(_$NewsDataImpl) then) =
      __$$NewsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? url, String? urlToImage});
}

/// @nodoc
class __$$NewsDataImplCopyWithImpl<$Res>
    extends _$NewsDataCopyWithImpl<$Res, _$NewsDataImpl>
    implements _$$NewsDataImplCopyWith<$Res> {
  __$$NewsDataImplCopyWithImpl(
      _$NewsDataImpl _value, $Res Function(_$NewsDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? url = freezed,
    Object? urlToImage = freezed,
  }) {
    return _then(_$NewsDataImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      urlToImage: freezed == urlToImage
          ? _value.urlToImage
          : urlToImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsDataImpl implements _NewsData {
  _$NewsDataImpl(
      {required this.title, required this.url, required this.urlToImage});

  factory _$NewsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsDataImplFromJson(json);

  @override
  final String? title;
  @override
  final String? url;
  @override
  final String? urlToImage;

  @override
  String toString() {
    return 'NewsData(title: $title, url: $url, urlToImage: $urlToImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.urlToImage, urlToImage) ||
                other.urlToImage == urlToImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, url, urlToImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsDataImplCopyWith<_$NewsDataImpl> get copyWith =>
      __$$NewsDataImplCopyWithImpl<_$NewsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsDataImplToJson(
      this,
    );
  }
}

abstract class _NewsData implements NewsData {
  factory _NewsData(
      {required final String? title,
      required final String? url,
      required final String? urlToImage}) = _$NewsDataImpl;

  factory _NewsData.fromJson(Map<String, dynamic> json) =
      _$NewsDataImpl.fromJson;

  @override
  String? get title;
  @override
  String? get url;
  @override
  String? get urlToImage;
  @override
  @JsonKey(ignore: true)
  _$$NewsDataImplCopyWith<_$NewsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
