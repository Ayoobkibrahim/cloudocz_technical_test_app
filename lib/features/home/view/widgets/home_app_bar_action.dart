import 'package:cloudocz_technical_test_app/config/components/bouncing_button_widget.dart';
import 'package:cloudocz_technical_test_app/data/local_storage.dart';
import 'package:cloudocz_technical_test_app/extensions/mediaquery_extension.dart';
import 'package:cloudocz_technical_test_app/features/profile/view/screen/profilescreen.dart';
import 'package:flutter/material.dart';

class HomeAppBarAction extends StatefulWidget {
  const HomeAppBarAction({
    super.key,
    required this.scrWidth,
  });

  final double scrWidth;

  @override
  State<HomeAppBarAction> createState() => _HomeAppBarActionState();
}

class _HomeAppBarActionState extends State<HomeAppBarAction> {
  late final LocalStorageService _localStorageService;

  @override
  void initState() {
    super.initState();
    _localStorageService = LocalStorageService();
  }

  Future<Map<String, String?>> _fetchUserData() async {
    final name = await _localStorageService.getName();
    final image = await _localStorageService.getImage();
    return {
      'name': name,
      'image': image,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BouncingButtonWidget(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Profilescreen(),
            ),
          );
        },
        child: FutureBuilder<Map<String, String?>>(
          future: _fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                children: [
                  const CircularProgressIndicator(),
                  (widget.scrWidth * 0.05).width,
                ],
              );
            }

            if (snapshot.hasError || snapshot.data == null) {
              return Row(
                children: [
                  const Text("Error"),
                  (widget.scrWidth * 0.05).width,
                ],
              );
            }

            final userData = snapshot.data!;
            final name = userData['name'] ?? "User";
            final image = userData['image'] ?? "";

            return Row(
              children: [
                Text(name),
                (widget.scrWidth * 0.02).width,
                CircleAvatar(
                  backgroundImage: image.isNotEmpty
                      ? NetworkImage(image)
                      : const AssetImage("assets/default_avatar.png")
                          as ImageProvider,
                ),
                (widget.scrWidth * 0.05).width,
              ],
            );
          },
        ),
      ),
    );
  }
}
