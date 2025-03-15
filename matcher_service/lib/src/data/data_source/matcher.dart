import 'package:core/core.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/availabel_time.dart';

part 'matcher.g.dart';

@RestApi()
abstract class MatcherDataSource {
  factory MatcherDataSource() => _MatcherDataSource(NetworkConfig.instance.dio);

  static const _prefix = '/matcher';
  static const _avaialableTimePrefix = '$_prefix/available-time';
  static const _person = '$_prefix/person';

  @POST('$_avaialableTimePrefix/add')
  @Headers({'Content-Type': 'application/json'})
  Future<HttpResponse> addAvailableTime(
    @Body() AvailabelTimeModel availabelTimeModel,
  );
}
