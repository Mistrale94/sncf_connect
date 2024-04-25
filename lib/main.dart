import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3, // Ajustez les flex pour la proportion de la carte
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(48.8684992, 2.3691753),
                  initialZoom: 15,
                ),
                children: <Widget>[
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  // D'autres layers ou marqueurs peuvent être ajoutés ici
                ],
              ),
            ),
            Expanded(
              flex:
                  4, // Ajustez les flex pour la proportion des autres éléments
              child: Container(
                  // Ce Container représentera la section en dessous de la carte.
                  // Ajoutez ici la barre de recherche, les informations de trafic, etc.
                  // Utilisez des widgets comme TextField, IconButton, etc.
                  ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          // Ajouter ici les éléments de navigation
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk),
              label: 'Voyager',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Billets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Offres',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Compte',
            ),
          ],
        ),
      ),
    );
  }
}
