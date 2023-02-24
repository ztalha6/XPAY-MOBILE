import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:serveeasy_app/app/data/services/image_util.dart';
import 'package:serveeasy_app/app/data/widgets/custom_text_form_field.dart';
import 'package:serveeasy_app/app/data/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(EditProfileController());
    return GetX<EditProfileController>(
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.image.value == null)
                      CircleAvatar(
                        backgroundColor:
                            model.configuration.secondaryColor.withOpacity(0.2),
                        radius: 50,
                        child: Icon(
                          Icons.camera_alt,
                          color: model.configuration.secondaryColor,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () async {
                          //open image viewer
                          if (model.image.value != null) {
                            final String base64String =
                                ImageUtil().toBase64(model.image.value!.bytes);
                            // Get.to(() => ImageView(imagePaths: [
                            //       MediaModel(
                            //           videoUrl: '',
                            //           isVideo: false,
                            //           imagePath: base64String)
                            //     ], selectedImage: 0));
                          } else {}
                        },
                        child: CircleAvatar(
                          radius: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: model.image.value!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    // CircleAvatar(
                    //   radius: 50,
                    //   backgroundColor:
                    //       model.configuration.secondaryColor.withOpacity(0.15),
                    //   child: Text(
                    //     model.getFirstLetter,
                    //     style: Theme.of(context).textTheme.headline1!.copyWith(
                    //           fontSize: 24,
                    //           color: model.configuration.secondaryColor,
                    //         ),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Profile Photo",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.bottomSheet(
                          Padding(
                            padding: const EdgeInsets.all(36.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      model.onChangePhotoTapped(
                                        camera: true,
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.camera,
                                          size: 50,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                          'Camera'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      model.onChangePhotoTapped();
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 50,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                          'Gallery'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          elevation: 20.0,
                          enableDrag: false,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        model.image.value == null
                            ? 'Upload Profile Photo'
                            : 'Change Profile',
                        // '${m.image.value == null ? 'Upload' : 'Change'} profile photo',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),

                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFormField(
                      label: 'Full Name',
                      errorText: model.nameErrorText.value,
                      controller: model.nameController,
                      hintText: "Enter Full Name",
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFormField(
                      label: 'Email Address',
                      errorText: model.emailErrorText.value,
                      controller: model.emailController,
                      hintText: "Enter Email",
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextFormField(
                      label: 'Your Phone Number',
                      errorText: model.phoneErrorText.value,
                      controller: model.phoneController,
                      hintText: "Enter Phone Number",
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: Get.height * 0.078,
                    ),
                    PrimaryButton(
                      // onTap: () => model.onUpdatePasswordTap(),
                      text: 'Save',
                      isLoading: model.isLoading.value,
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
