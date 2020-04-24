import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'page.dart';

const LatLng defaultLocation = const LatLng(-33.4409543,-70.6533457);
const double defaultZoom = 15.02;


class ExampleAppPage extends ExamplePage {
  ExampleAppPage()
      : super(const Icon(Icons.star), 'Example App');

  @override
  Widget build(BuildContext context) {
    return const ExampleApp();
  }
}

class ExampleApp extends StatefulWidget {
  const ExampleApp();

  @override
  State createState() => ExampleAppState();
}

class ExampleAppState extends State<ExampleApp> {
  MapboxMapController controller;
  Symbol _selectedSymbol;

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
    controller.onSymbolTapped.add(_onSymbolTapped);
    _add('airport-15');
  }

  @override
  void dispose() {
    controller?.onSymbolTapped?.remove(_onSymbolTapped);
    super.dispose();
  }

  void _updateSelectedSymbol(SymbolOptions changes) {
    controller.updateSymbol(_selectedSymbol, changes);
  }

  void _onSymbolTapped(Symbol symbol) {
    _updateSelectedSymbol(
      const SymbolOptions(iconSize: 1.0),
    );
    setState(() {
      _selectedSymbol = symbol;
    });
    _updateSelectedSymbol(
      SymbolOptions(
        iconSize: 1.4,
      ),
    );
  }

  void _add(String iconImage) {
    controller.addSymbol(
      SymbolOptions(
        geometry: defaultLocation,
        iconImage: iconImage,
      ),
    );
    // setState(() {
      // _symbolCount += 1;
    // });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: MapboxMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:
          const CameraPosition(target: defaultLocation, zoom: defaultZoom),
          styleString: MapboxStyles.DARK,
        )
    );
  }
}
