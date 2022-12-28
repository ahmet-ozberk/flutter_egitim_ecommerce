import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/model/profile_menu_model.dart';
import 'package:flutter_egitim_ecommerce/view/login_view.dart';
import 'package:flutter_egitim_ecommerce/view/password_update_view.dart';
import 'package:flutter_egitim_ecommerce/view/previous_orders_view.dart';
import 'package:flutter_egitim_ecommerce/view/profile_edit_view.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<ProfileMenuModel> menuItems = [];
  File? selectedImage;
  final String kvkk =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Semper eget duis at tellus at urna condimentum mattis. Dolor sed viverra ipsum nunc aliquet. Et tortor consequat id porta nibh venenatis cras. Aliquet lectus proin nibh nisl condimentum id venenatis a condimentum. Ac odio tempor orci dapibus ultrices in iaculis nunc. Nibh mauris cursus mattis molestie. Donec enim diam vulputate ut. Nisl vel pretium lectus quam id leo in vitae. Fermentum iaculis eu non diam phasellus. Lacus laoreet non curabitur gravida. Sed sed risus pretium quam vulputate dignissim suspendisse in. Nunc vel risus commodo viverra maecenas accumsan lacus. Non consectetur a erat nam at lectus urna duis. Nam at lectus urna duis convallis convallis.';

  void initialize() {
    menuItems.addAll([
      ProfileMenuModel(
          leading: Icons.edit_note_rounded,
          text: "Profilimi Düzenle",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileEditView()));
          }),
      ProfileMenuModel(
          leading: Icons.lock,
          text: "Şifremi Değiştir",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordUpdateView()));
          }),
      ProfileMenuModel(
          leading: Icons.shopify_rounded,
          text: "Önceki Siparişlerim",
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PreviousOrdersView()));
          }),
      ProfileMenuModel(
          leading: Icons.text_fields_rounded,
          text: "KVKK ve Kullanım Koşulları",
          onTap: () {
            contractsPopup();
          }),
      ProfileMenuModel(
        leading: Icons.exit_to_app_rounded,
        text: "Çıkış Yap",
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false,
          );
        },
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColor.pink.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColor.yellow.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: AppColor.orange.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => selectPhoto(),
                      child: Container(
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                          ),
                        ]),
                        child: selectedImage != null
                            ? ClipOval(
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.add_a_photo),
                      ),
                    ),
                  ),
                  const Text(
                    "Ahmet Özberk",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "Ayarlar",
                        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menuItems.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return _profileMenu(item);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void contractsPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "KVKK",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  kvkk,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Divider(),
                Text(
                  "Mesafeli Satış Sözleşmesi",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  kvkk * 2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future imagePickerService(ImageSource type) async {
    final XFile? image = await ImagePicker().pickImage(source: type);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void selectPhoto() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Fotoğraf Yükle"),
          content: const Text("Lütfen fotoğrafınızı nerden yüklemek istediğinizi seçiniz."),
          actions: [
            CupertinoDialogAction(
              child: const Text("Galeri"),
              onPressed: () {
                Navigator.pop(context);
                imagePickerService(ImageSource.gallery);
              },
            ),
            CupertinoDialogAction(
              child: const Text("Kamera"),
              onPressed: () {
                Navigator.pop(context);
                imagePickerService(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _profileMenu(ProfileMenuModel model) {
    return GestureDetector(
      onTap: () => model.onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        color: Colors.grey.shade100,
        child: Row(
          children: [
            Icon(model.leading, color: Colors.blueGrey),
            const SizedBox(
              width: 12,
            ),
            Text(
              model.text,
              style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
