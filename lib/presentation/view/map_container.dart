import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapsContainer extends StatefulWidget {
  const MapsContainer({Key? key}) : super(key: key);

  @override
  State<MapsContainer> createState() => _MapsContainerState();
}

class _MapsContainerState extends State<MapsContainer>
    with WidgetsBindingObserver {
  final mapController = MapController.withUserPosition(
      trackUserLocation: const UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // _loadMapStyles();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {
      // _setMapStyle();
    });
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
        controller: mapController,
        osmOption: OSMOption(
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: false,
          ),
          zoomOption: ZoomOption(
            initZoom: 17,
            minZoomLevel: 3,
            stepZoom: 1.0,
          ),
          userLocationMarker: UserLocationMaker(
            personMarker: const MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 64,
              ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          roadConfiguration: const RoadOption(
            roadColor: Colors.yellowAccent,
          ),
          markerOption: MarkerOption(
              defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          )),
        ));
  }
}
