import 'dart:convert';

import 'package:admin_shop/data/local/local_data.dart';
import 'package:admin_shop/data/remote/remote_data.dart';
import 'package:http/http.dart';

class MetricRepository {
  static getMetrics() async {
    final jwt = await JwtProvider.getJwt();
    final Response response = await DataProvider.getData('metrics/admin', jwt: jwt);
    // print(response.body);
    final Map data = {'data': json.decode(response.body)};
    return data;
  }
}
