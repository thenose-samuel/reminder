import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(GetMaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}

class ListFollowUnfollowButton extends StatelessWidget {

  late dynamic cardData;
  late dynamic controller;
  ListFollowUnfollowButton({Key? key, required this.cardData, required this.controller}) : super(key: key);

  Rx<bool> spinner= false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        spinner.value = !spinner.value;
        //print('Button tapped')
        bool status = await controller.followFollowing(
          actionType: cardData.isFollowing? 'Unfollow' : 'Follow', userId: cardData.userId
        );
        if(status) cardData.isFollowing = !cardData.isFollowing;
        controller.followData.refresh();
        spinner.value = !spinner.value;
      },
      child: Container(
        height: Get.height * 0.06,
        width: Get.width * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF2687C8),
          ),
        ),
        child: Center(
          child: Obx(
            () => (spinner.value)
                ? SizedBox(
                    width: Get.width * 0.05,
                    height: Get.height * 0.03,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    cardData.isFollowing ? 'Following' : 'Follow',
                    style: const TextStyle(
                        color: Color(0xFF2687C8),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
