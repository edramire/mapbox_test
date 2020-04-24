// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_test/examples/full_map.dart';

import 'examples/animate_camera.dart';
import 'examples/full_map.dart';
import 'examples/line.dart';
import 'examples/map_ui.dart';
import 'examples/move_camera.dart';
import 'examples/page.dart';
import 'examples/place_circle.dart';
import 'examples/place_symbol.dart';
import 'examples/scrolling_map.dart';
import 'examples/example_app.dart';

final List<ExamplePage> _allPages = <ExamplePage>[
  MapUiPage(),
  FullMapPage(),
  AnimateCameraPage(),
  MoveCameraPage(),
  PlaceSymbolPage(),
  LinePage(),
  PlaceCirclePage(),
  ScrollingMapPage(),
  ExampleAppPage(),
];

class MapsDemo extends StatelessWidget {
  void _pushPage(BuildContext context, ExamplePage page) async {
    final location = Location();
    final hasPermissions = await location.hasPermission();
    if (hasPermissions != PermissionStatus.granted) {
      await location.requestPermission();
    }

    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapboxMaps examples')),
      body: ListView.builder(
        itemCount: _allPages.length,
        itemBuilder: (_, int index) => ListTile(
          leading: _allPages[index].leading,
          title: Text(_allPages[index].title),
          onTap: () => _pushPage(context, _allPages[index]),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MapsDemo()));
}
