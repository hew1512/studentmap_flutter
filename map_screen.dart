import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'app_theme.dart';
import 'profile_screen.dart';

class MapScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const MapScreen({super.key, required this.user});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();

  final LatLng universityLocation = const LatLng(13.7563, 100.5018);

  @override
  Widget build(BuildContext context) {
    final name = widget.user['name'] ?? 'Student';

    return Scaffold(
      body: Stack(
        children: [
          // =========================
          // MAP
          // =========================
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: universityLocation,
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.final_project',
              ),

              // University marker
              MarkerLayer(
                markers: [
                  Marker(
                    point: universityLocation,
                    width: 70,
                    height: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // =========================
          // TOP BAR
          // =========================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Welcome, $name',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Profile button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfileScreen(user: widget.user),
                        ),
                      );
                    },
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =========================
          // RIGHT BUTTONS
          // =========================
          Positioned(
            right: 18,
            bottom: 35,
            child: Column(
              children: [
                // Location button
                FloatingActionButton(
                  heroTag: 'location',
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primary,
                  elevation: 5,
                  onPressed: () {
                    mapController.move(universityLocation, 15);
                  },
                  child: const Icon(Icons.my_location_rounded),
                ),

                const SizedBox(height: 12),

                // Profile button
                FloatingActionButton(
                  heroTag: 'profile',
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: widget.user),
                      ),
                    );
                  },
                  child: const Icon(Icons.person_rounded),
                ),
              ],
            ),
          ),

          // =========================
          // BOTTOM INFORMATION CARD
          // =========================
          Positioned(
            left: 18,
            right: 18,
            bottom: 25,
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      color: AppTheme.primary,
                      size: 28,
                    ),

                    SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student Location',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textDark,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            'Explore the map and find your destination',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
