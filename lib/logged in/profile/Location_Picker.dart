import 'package:flutter/material.dart';
import 'package:flutter_osm_interface/flutter_osm_interface.dart';
import 'package:flutter_osm_plugin/src/controller/map_controller.dart';
import 'package:flutter_osm_plugin/src/osm_flutter.dart';
import 'package:test_app/Shakoosh_icons.dart';
import 'package:lottie/lottie.dart';

Future<GeoPoint?> showSimplePickerLocation({
  required BuildContext context,
  GeoPoint? initPosition,
  bool isDismissible = false,
  bool initCurrentUserPosition = true,
}) async {
  assert(true);
  assert((initCurrentUserPosition && initPosition == null) ||
      !initCurrentUserPosition && initPosition != null);
  final MapController controller = MapController(
    initMapWithUserPosition: initCurrentUserPosition,
    initPosition: initPosition,
  );

  GeoPoint? point = await showDialog(
    context: context,
    builder: (ctx) {
      return WillPopScope(
        onWillPop: () async {
          return isDismissible;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.9,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: Container(
              color: Theme.of(context).colorScheme.secondary,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(ShakooshIcons.logo_transparent_black_2,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 30),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Set a location",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary),
                      )
                    ]),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            contentPadding: const EdgeInsets.all(0),
            titlePadding: const EdgeInsets.all(0),
            actionsPadding: const EdgeInsets.only(top: 5),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,
              child: OSMFlutter(
                controller: controller,
                isPicker: true,
                mapIsLoading: Container(
                  padding: const EdgeInsets.all(100),
                  child: Lottie.asset(
                      'assets/animations/logo_appears_from_down.json'),
                ),
                markerOption: MarkerOption(
                  advancedPickerMarker: const MarkerIcon(
                    icon: Icon(
                      ShakooshIcons.helmet_marker,
                      color: Color.fromARGB(255, 51, 51, 51),
                      size: 150,
                    ),
                  ),
                ),
                stepZoom: 1,
                initZoom: 15,
                minZoomLevel: 2,
                maxZoomLevel: 18,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                style: TextButton.styleFrom(
                  fixedSize: const Size(50, 6),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                ),
                child: const Text("Cancel",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
              TextButton(
                onPressed: () async {
                  final p = await controller
                      .getCurrentPositionAdvancedPositionPicker();
                  await controller.cancelAdvancedPositionPicker();
                  Navigator.pop(ctx, p);
                },
                style: TextButton.styleFrom(
                    fixedSize: const Size(50, 6),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
                child: const Text("Pick",
                    style: TextStyle(color: Colors.black54, fontSize: 14)),
              ),
            ],
          ),
        ),
      );
    },
  );

  return point;
}
