
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serveeasy_app/app/data/models/user_model.dart';
import 'package:serveeasy_app/app/data/services/user_manager.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';

class EditProfileController extends GetxController {
  Configuration configuration = Configuration();
  Rxn<MemoryImage> image = Rxn<MemoryImage>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RxnString nameErrorText = RxnString();
  RxnString emailErrorText = RxnString();
  RxnString phoneErrorText = RxnString();

  RxBool isLoading = false.obs;
  RxString userName = "S".obs;
  Rxn<User> user = Rxn<User>();

  String get getFirstLetter => userName.value.characters.first;

  @override
  Future<void> onInit() async {
    isLoading(true);
    await setUserData();
    isLoading(false);
    super.onInit();
  }

  Future<void> setUserData() async {
    user.value = await UserManager().getUser();
    userName.value = user.value!.fullName ?? "S";
    nameController.text = user.value!.fullName!;
    emailController.text = user.value!.email!;
    phoneController.text = user.value!.phone!;
  }

  Future<void> onChangePhotoTapped({bool camera = false}) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
    );
    if (image != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        // androidUiSettings: AndroidUiSettings(
        //     toolbarColor: AppTheme.orange,
        //     toolbarWidgetColor: Colors.white,
        //     initAspectRatio: CropAspectRatioPreset.original,
        //     lockAspectRatio: false),
        // iosUiSettings: const IOSUiSettings(
        //   minimumAspectRatio: 1.0,
        // ),
      );
      if (croppedFile != null) {
        image = XFile(croppedFile.path);
      }
      this.image.value = MemoryImage(await image.readAsBytes());
    }
  }
}
