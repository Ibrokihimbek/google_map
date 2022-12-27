import 'package:flutter/material.dart';
import 'package:google_map/data/api/api_service.dart';
import 'package:google_map/data/models/lat_long.dart';
import 'package:google_map/data/repositories/geociding_repository.dart';
import 'package:google_map/view_models/map_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.latLong}) : super(key: key);
  final LatLong latLong;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

const List<String> list = <String>[
  'choose kind',
  'house',
  'locality',
  'street',
  'metro',
  'district',
];

class _MapScreenState extends State<MapScreen> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          MapViewModel(geocodingRepo: GeocodingRepo(apiService: ApiService())),
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            body: Consumer<MapViewModel>(
              builder: (context, viewModel, child) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          onMapCreated: (GoogleMapController controller) {},
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              widget.latLong.lattitude,
                              widget.latLong.longitude,
                            ),
                            zoom: 19.151926040649414,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 100,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 5,
                              color: Colors.white,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                context.read<MapViewModel>().fetchAddress(
                                    latLong: widget.latLong, kind: value!);
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 22,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          width: 300,
                          child: Text(
                            "Map Screen: ${viewModel.addressText}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
