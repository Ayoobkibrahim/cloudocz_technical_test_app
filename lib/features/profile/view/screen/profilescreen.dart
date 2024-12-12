import 'package:cloudocz_technical_test_app/data/local_storage.dart';
import 'package:cloudocz_technical_test_app/extensions/mediaquery_extension.dart';
import 'package:cloudocz_technical_test_app/features/profile/view/widgets/logout_button_widget.dart';
import 'package:cloudocz_technical_test_app/features/profile/view/widgets/profile_task_details.dart';
import 'package:flutter/material.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  late final LocalStorageService _localStorageService;

  @override
  void initState() {
    super.initState();
    _localStorageService = LocalStorageService();
  }

  Future<Map<String, String?>> _fetchUserData() async {
    final name = await _localStorageService.getName();
    final image = await _localStorageService.getImage();
    final position = await _localStorageService.getPosition();
    final noOfTasks = await _localStorageService.getNoTask();
    final percentage = await _localStorageService.getPercentage();
    return {
      'name': name,
      'image': image,
      'position': position,
      'tasks': noOfTasks,
      'percentage': percentage,
    };
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = context.mediaQueryHeight;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: FutureBuilder<Map<String, String?>>(
          future: _fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text("Error loading profile data"));
            }

            final userData = snapshot.data!;
            final name = userData['name'] ?? "User";
            final image = userData['image'] ?? "";
            final position = userData['position'] ?? "N/A";
            final tasks = userData['tasks'] ?? "0";
            final percentage = userData['percentage'] ?? "0";

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(23),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: scrHeight * 0.07,
                            backgroundImage: image.isNotEmpty
                                ? NetworkImage(image)
                                : const AssetImage("assets/default_avatar.png")
                                    as ImageProvider,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: scrHeight * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            position,
                            style: TextStyle(
                              fontSize: scrHeight * 0.018,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ProfileTaskDetails(
                            tasks: tasks,
                            percentage: percentage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const LogoutButtonWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
