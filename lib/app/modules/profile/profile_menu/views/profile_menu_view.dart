import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

import '../controllers/profile_menu_controller.dart';

class ProfileMenuView extends GetView<ProfileMenuController> {
  const ProfileMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileMenuController());
    return GetX<ProfileMenuController>(
      dispose: (s) {
        Get.delete<ProfileMenuController>();
      },
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            leading: InkWell(
              onTap: () => ZoomDrawer.of(context)!.toggle(),
              child: Image.asset(
                menuIcon,
                scale: 2.5,
              ),
            ),
          ),
          body: Column(
            children: [
              if (model.isLoading.isTrue)
                LinearProgressIndicator(
                  color: model.configuration.secondaryColor,
                  backgroundColor:
                      model.configuration.secondaryColor.withOpacity(0.5),
                )
              else
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: model.configuration.secondaryColor
                              .withOpacity(0.15),
                          child: Text(
                            model.getFirstLetter,
                            style:
                                Theme.of(context).textTheme.displayLarge!.copyWith(
                                      fontSize: 24,
                                      color: model.configuration.secondaryColor,
                                    ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width / 1.6,
                                    child: Text(
                                      model.userName.value,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: Get.width / 1.6,
                                    child: Text(
                                      model.user.value!.email!,
                                      maxLines: 1,
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    child: Text(
                                      model.user.value!.phone!,
                                      maxLines: 1,
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  model.gotoEditProfile();
                                },
                                child: Image.asset(
                                  editIcon,
                                  scale: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      onTap: () {
                        model.gotoAddresses();
                      },
                      leading: Image.asset(
                        locationIcon,
                        scale: 2.8,
                      ),
                      title: 'Address',
                    ),
                    const SizedBox(height: 6),
                    ProfileMenuItem(
                      onTap: () {
                        model.gotoPayment();
                      },
                      leading: Image.asset(
                        cardIcon,
                        scale: 2.8,
                        color: Colors.black,
                      ),
                      title: 'Payment Managment',
                    ),
                    const SizedBox(height: 6),
                    ProfileMenuItem(
                      onTap: () {
                        model.gotoChangePassword();
                      },
                      leading: Image.asset(
                        lockIcon,
                        scale: 2.8,
                      ),
                      title: 'Change Password',
                    ),
                    const SizedBox(height: 6),
                    ProfileMenuItem(
                      onTap: () {
                        model.gotoDeleteAccount();
                      },
                      leading: Image.asset(
                        deleteIcon,
                        scale: 2.8,
                        color: Colors.red,
                      ),
                      color: Colors.red,
                      title: 'Delete Account',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    Key? key,
    required this.title,
    required this.leading,
    this.onTap,
    this.color = Colors.black,
  }) : super(key: key);
  final String title;
  final Widget leading;
  final Color? color;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 13, color: color),
        ),
        leading: leading,
      ),
    );
  }
}
