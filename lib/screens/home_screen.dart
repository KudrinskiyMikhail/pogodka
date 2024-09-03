import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YandexMapController _controller;

  final Point _initialPosition = const Point(latitude: 55.751244, longitude: 37.618423); // Координаты Москвы
  final List<MapObject> _mapObjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pogodka Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Переход на экран профиля
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (YandexMapController controller) {
              _controller = controller;
              _moveToInitialPosition();
              _addMarkers();
            },
            mapObjects: _mapObjects,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 60, // Ширина кнопки
                    height: 60, // Высота кнопки
                    child: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.black),
                      iconSize: 40, // Размер иконки
                      onPressed: () {
                        // Действие для кнопки "Избранное"
                      },
                    ),
                  ),
                  SizedBox(height: 20), // Отступ между кнопками
                  SizedBox(
                    width: 60, // Ширина кнопки
                    height: 60, // Высота кнопки
                    child: IconButton(
                      icon: Icon(Icons.settings, color: Colors.black),
                      iconSize: 40, // Размер иконки
                      onPressed: () {
                        // Действие для кнопки "Настройки"
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      _controller.moveCamera(
                        CameraUpdate.zoomIn(),
                      );
                    },
                    backgroundColor: Colors.grey, // Изменение цвета кнопки
                    child: Icon(Icons.add, color: Colors.white), // Цвет иконки
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: () {
                      _controller.moveCamera(
                        CameraUpdate.zoomOut(),
                      );
                    },
                    backgroundColor: Colors.grey, // Изменение цвета кнопки
                    child: Icon(Icons.remove, color: Colors.white), // Цвет иконки
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Действие для поиска
              },
              backgroundColor: Colors.grey,
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }

  void _moveToInitialPosition() {
    _controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPosition, zoom: 12.0),
      ),
    );
  }

  void _addMarkers() {
    final placemark = PlacemarkMapObject(
      mapId: MapObjectId('placemark_1'),
      point: Point(latitude: 55.751244, longitude: 37.618423), // Координаты маркера
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('lib/assets/marker.png'),
          scale: 1.0,
        ),
      ),
      opacity: 0.9,
    );

    setState(() {
      _mapObjects.add(placemark);
    });
  }
}

