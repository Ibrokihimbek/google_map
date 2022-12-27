import 'package:flutter/cupertino.dart';
import 'package:google_map/data/models/lat_long.dart';
import 'package:google_map/data/models/my_response/response_model.dart';
import 'package:google_map/data/repositories/geociding_repository.dart';

class MapViewModel extends ChangeNotifier {
  MapViewModel({required this.geocodingRepo});

  final GeocodingRepo geocodingRepo;

  String addressText = "";
  String errorForUI = "";

  fetchAddress({required LatLong latLong, required String kind}) async {
    AppResponse appResponse = await geocodingRepo.getAddress(latLong, kind);
    if (appResponse.error.isEmpty) {
      addressText = appResponse.data;
    } else {
      errorForUI = appResponse.error;
    }
    notifyListeners();
  }
}