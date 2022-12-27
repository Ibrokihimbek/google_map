import 'package:google_map/data/api/api_service.dart';
import 'package:google_map/data/models/lat_long.dart';
import 'package:google_map/data/models/my_response/response_model.dart';

class GeocodingRepo {
  GeocodingRepo({required this.apiService});

  final ApiService apiService;

  Future<AppResponse> getAddress(LatLong latLong, String kind) =>
      apiService.getLocationName(
          geoCodeText: "${latLong.longitude},${latLong.lattitude}", kind: kind);
}
