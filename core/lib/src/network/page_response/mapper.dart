part of 'entity.dart';

extension PageableReponseMapper on PageableResponseModel {
  PageableResponse toDomain() => PageableResponse(
        size: size,
        totalElements: totalElements,
        totalPages: totalPages,
        number: number,
      );
}