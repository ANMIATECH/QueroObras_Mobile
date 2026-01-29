import '../../../const/export.dart';

class ServiceRequestScreen extends StatefulWidget {
  final String providerName;
  final String serviceName;
  final String amount;
  final String imageUrl;
  final String serviceProviderId;
  final double providerLat; // latitude of provider
  final double providerLng; // longitude of provider

  const ServiceRequestScreen({
    super.key,
    required this.providerName,
    required this.serviceName,
    required this.amount,
    required this.imageUrl,
    required this.providerLat,
    required this.providerLng,
    required this.serviceProviderId,
  });

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  late GoogleMapController mapController;
  LatLng? userLocation;
  int? estimatedMinutes; // Estimated arrival time in minutes

  @override
  void initState() {
    super.initState();
    _getUserLocationAndCalculateArrival();
  }

  Future<void> _getUserLocationAndCalculateArrival() async {
    try {
      // Get user location with new LocationSettings
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        // Cannot access location
        setState(() {
          estimatedMinutes = -1; // or display a message
        });
        return;
      }

      // Calculate distance to provider in km
      double distanceKm =
          Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            widget.providerLat,
            widget.providerLng,
          ) /
          1000;

      // Assume average speed (e.g., 40 km/h)
      double averageSpeedKmH = 40;
      int minutes = (distanceKm / averageSpeedKmH * 60).ceil();

      setState(() {
        estimatedMinutes = minutes;
      });
    } catch (e) {
      CustomLoading.showNotification(
        message: e.toString(),
        messageType: MessageType.error,
      );
    }
  }

  String formatArrivalTime(int totalMinutes) {
    if (totalMinutes < 60) return '$totalMinutes min';

    int minutes = totalMinutes % 60;
    int totalHours = totalMinutes ~/ 60;

    if (totalHours < 24) return '${totalHours}h ${minutes}min';

    int hours = totalHours % 24;
    int totalDays = totalHours ~/ 24;

    if (totalDays < 7) return '${totalDays}d ${hours}h ${minutes}min';

    int days = totalDays % 7;
    int totalWeeks = totalDays ~/ 7;

    if (totalWeeks < 4)
      return '${totalWeeks}w ${days}d ${hours}h ${minutes}min';

    int weeks = totalWeeks % 4;
    int totalMonths = totalWeeks ~/ 4;

    if (totalMonths < 12)
      return '${totalMonths}mo ${weeks}w ${days}d ${hours}h ${minutes}min';

    int months = totalMonths % 12;
    int years = totalMonths ~/ 12;

    return '${years}y ${months}mo ${weeks}w ${days}d ${hours}h ${minutes}min';
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};

    if (userLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('user'),
          position: userLocation!,
          infoWindow: const InfoWindow(title: 'You'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      markers.add(
        Marker(
          markerId: const MarkerId('provider'),
          position: LatLng(widget.providerLat, widget.providerLng),
          infoWindow: InfoWindow(title: widget.providerName),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.serviceName)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: userLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: userLocation!,
                        zoom: 14,
                      ),
                      markers: markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      onMapCreated: (controller) => mapController = controller,
                    ),
            ),
            const SizedBox(height: 20),
            // Provider info and actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: 220,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F3F3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CustomImageView(
                                    imagePath: widget.imageUrl,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 11),
                              SizedBox(
                                width: 74,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.providerName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Josefin Sans',
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      widget.serviceName,
                                      style: const TextStyle(
                                        color: Color(0xFF7E7878),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Josefin Sans',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Text(
                              widget.amount,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontFamily: 'Josefin Sans',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              estimatedMinutes != null
                                  ? (estimatedMinutes! >= 0
                                        ? 'Chegada estimada: ${formatArrivalTime(estimatedMinutes!)}'
                                        : 'Permissão de localização negada')
                                  : 'Calculando...',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF979797),
                                fontFamily: 'Josefin Sans',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ActionButton(
                    text: 'solicitar serviço',
                    backgroundColor: const Color(0xFFF9761E),
                    textColor: Colors.white,
                    onPressed: () {
                      Get.to(
                        () => RequestService(
                          serviceProviderId: widget.serviceProviderId,
                        ),
                      );
                      // Navigator.of(context).pushNamed(AppRoutes.oneOnOneChat);
                      debugPrint('IMAGE URL => ${widget.imageUrl}');
                    },
                  ),
                  const SizedBox(height: 10),
                  ActionButton(
                    text: 'Cancelar',
                    backgroundColor: const Color(0xFFF4F3F3),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;

  const ActionButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 70),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textColor,
            fontFamily: 'Josefin Sans',
          ),
        ),
      ),
    );
  }
}
