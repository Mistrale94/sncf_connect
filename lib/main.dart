import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double mapHeight = 312; // Hauteur fixe pour la carte.

    return Scaffold(
      backgroundColor: const Color(0xFF0C131F),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  // Marge en bas pour la carte.
                  width: double.infinity,
                  height: mapHeight, // Utiliser une hauteur fixe pour la carte.
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(48.8684992, 2.3691753),
                      initialZoom: 18.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: mapHeight -
                      24, // Pour que la barre de recherche chevauche la carte
                  left: 16,
                  right: 16,
                  height: 48,
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        hintText: 'Une destination, demande...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFFFFCDA8),
                            child: Icon(Icons.mic, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliderMenu(),
          const TrafficInfoBanner(),
          const RecentTripsSection(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Voyager',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.train),
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
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 115, 247, 240),
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF0C131F),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Assurez-vous de définir le widget SliderDiv quelque part dans votre code.
class SliderMenu extends StatelessWidget {
  const SliderMenu({Key? key}) : super(key: key);
  // ... constructeur et autres méthodes ...

  @override
  Widget build(BuildContext context) {
    // Liste des éléments du slider
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.home,
        'label': 'Maison',
        'address': '11 rue d\'Orsel',
      },
      {
        'icon': Icons.work,
        'label': 'Travail',
        'address': '93 rue Sedaine',
      },
      {
        'icon': Icons.star,
        'label': 'Adresse',
        'address': 'Votre destination',
      },
    ];

    return SizedBox(
      height: 80,
      // Hauteur ajustée pour donner plus d'espace
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16), // Ajouter du padding vertical si nécessaire
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(36, 43, 53, 100),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Ajouter du padding horizontal
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: const Color(0xFFFFCDA8),
                  child: Icon(
                    items[index]['icon'],
                    size: 32,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8), // Espace entre l'icône et le texte
                Expanded(
                  // Permet au texte de prendre tout l'espace restant
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligner le texte à gauche
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centrer les éléments verticalement
                    children: <Widget>[
                      Text(
                        items[index]['label'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white),
                      ),
                      Text(
                        items[index]['address'],
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TrafficInfoBanner extends StatelessWidget {
  const TrafficInfoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alignement horizontal au début
        children: [
          // Ligne avec Infos trafic et réseaux et En savoir plus
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Infos trafic et réseaux',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Action pour "En savoir plus"
                },
                child: const Text(
                  'En savoir plus',
                  style: TextStyle(
                    color: Color.fromRGBO(141, 232, 254, 1),
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 16), // Espace entre le texte et les indicateurs
          // Conteneur pour les indicateurs avec couleur de fond
          Container(
            height: 73,
            decoration: BoxDecoration(
              color: const Color(0xFF262F3D), // Couleur de fond des indicateurs
              borderRadius:
                  BorderRadius.circular(10), // Bords arrondis du conteneur
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: List.generate(3, (index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: index == 2
                              ? Colors.red
                              : const Color.fromARGB(255, 197, 179, 16),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            index == 2 ? 'A' : '${9 - index}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0, // Ajustez selon le design
                        top: -6, // Ajustez selon le design
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.error_outline,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentTripsSection extends StatelessWidget {
  const RecentTripsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Vous pouvez définir une liste ou obtenir ces données depuis une source externe.
    final List<Map<String, dynamic>> trips = [
      {
        'lineType': 'RER', // Type de ligne (Métro, RER, etc.)
        'lineName': 'A', // Nom de la ligne
        'destination': 'Marne la vallée - chessy', // Destination
        'colors': [Colors.red, Colors.blue], // Couleurs pour la ligne RER A
      },
      // Ajoutez plus de trajets si nécessaire.
    ];

    return Container(
      color: Color(0xFF5D3FD3), // Arrière-plan violet
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vos trajet récent',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: trips.map((trip) {
                return Card(
                  color: Color(0xFF262F3D), // Couleur de fond de la carte
                  child: ListTile(
                    leading: _buildLeading(
                        trip['lineType'], trip['lineName'], trip['colors']),
                    title: Text(
                      trip['destination'],
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeading(String lineType, String lineName, List<Color> colors) {
    return Container(
      width: 40, // Largeur du conteneur de la ligne
      height: 40, // Hauteur du conteneur de la ligne
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Arrondir les bords
        color: colors.first, // Couleur de fond du cercle
      ),
      child: Center(
        child: Text(
          lineType + '\n' + lineName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
