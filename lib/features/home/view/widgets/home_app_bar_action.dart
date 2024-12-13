import 'package:cloudocz_technical_test_app/config/components/bouncing_button_widget.dart';
import 'package:cloudocz_technical_test_app/data/local_storage.dart';
import 'package:cloudocz_technical_test_app/config/extensions/mediaquery_extension.dart';
import 'package:cloudocz_technical_test_app/features/profile/view/screen/profilescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAppBarAction extends StatefulWidget {
  const HomeAppBarAction({super.key});

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
    double scrWidth = context.mediaQueryWidth;

    return BouncingButtonWidget(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
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
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(width: scrWidth * 0.02),
                  const Text(
                    "Loading...",
                    style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                  ),
                ],
              );
            }

            if (snapshot.hasError || snapshot.data == null) {
              return Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: scrWidth * 0.02),
                  const Text(
                    "Error",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ],
              );
            }

            final userData = snapshot.data!;
            final name = userData['name'] ?? "User";
            final image = userData['image'] ?? "";

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent.withOpacity(0.2), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.3),
                  //     blurRadius: 10,
                  //     spreadRadius: 2,
                  //     offset: const Offset(0, 4),
                  //   ),
                  // ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      (scrWidth * 0.01).width,
                      // Greeting and Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome back,",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(width: scrWidth * 0.02),

                      // Avatar with Border
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundImage: image.isNotEmpty
                              ? NetworkImage(image)
                              : const AssetImage("assets/default_avatar.png")
                                  as ImageProvider,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
