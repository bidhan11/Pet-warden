import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/profile_page_controller.dart';
import 'package:petwarden/repo/profile_repo.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/view/auth/log_in_screen.dart';
import 'package:petwarden/view/profile/change_password.dart';
import 'package:petwarden/view/profile/pet-owner_detail.dart';
import 'package:petwarden/view/profile/pets_page.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:petwarden/widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  final c = Get.find<ProfilePageController>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(65),
                    child: CustomNetworkImage(imageUrl: c.user.value?.profileImageUrl ?? ""),
                    // child: Image.asset(ImagePath.profilePic, fit: BoxFit.cover),
                  ),
                ),
                Text(
                  c.user.value?.name ?? "",
                  style: CustomTextStyles.f20W600(),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  c.user.value?.email ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.f14W500(color: PetWardenColors.textGrey),
                ),
                const SizedBox(
                  height: 45,
                ),
                ProfileTile(
                  iconUrl: IconPath.myDetailsIcon,
                  title: "My Details",
                  hasArrow: true,
                  onTap: () {
                    Get.toNamed(PetOwnerDetails.routeName);
                  },
                ),
                ProfileTile(
                  iconUrl: IconPath.petDetailsIcon,
                  title: "Pet Profiles",
                  hasArrow: true,
                  onTap: () {
                    Get.toNamed(PetsPage.routeName);
                  },
                ),
                ProfileTile(
                  iconUrl: IconPath.passwordIcon,
                  title: "Change Password",
                  hasArrow: true,
                  onTap: () {
                    Get.toNamed(ChangePassword.routeName);
                  },
                ),
                const ProfileTile(
                  iconUrl: IconPath.helpIcon,
                  title: "Get Help",
                  hasArrow: true,
                ),
                const ProfileTile(
                  iconUrl: IconPath.aboutUsIcon,
                  title: "About us",
                  hasArrow: true,
                ),
                ProfileTile(
                    iconUrl: IconPath.deleteUserIcon,
                    title: "Delete Account",
                    hasArrow: false,
                    onTap: () {
                      c.deleteAccount();
                    }),
                ProfileTile(
                  iconUrl: IconPath.logOutIcon,
                  title: "Log Out",
                  hasArrow: false,
                  onTap: () {
                    c.cc.logOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
