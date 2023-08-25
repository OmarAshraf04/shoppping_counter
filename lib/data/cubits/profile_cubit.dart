import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_2/data/cubits/profile_state.dart';
import 'package:shopping_2/data/models/data_user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  //For Profile Page
  DataUserModel? userData;

  Future<void> receiveFromFireStore() async {
    try {
      emit(LoadingProfileState());
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot? userA =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      userData = DataUserModel(
          name: userA['name'],
          email: userA['email'],
          password: userA['password'],
          uid: userA['uid'],
          image: userA['image']);
      emit(DoneProfileState());
    } catch (e) {
      emit(ErrorProfileState(e.toString()));
    }
  }

  ImagePicker picker = ImagePicker();

  File? image;

  Future<void> getPicture() async {
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      uploadPicture(File(image!.path));
      emit(TakePicture());
    }
  }

  Future<void> uploadPicture(File profile) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      String url;

      final ref = FirebaseStorage.instance
          .ref()
          .child('UsersProfiles')
          .child('${DateTime.now()}.jpg');

      await ref.putFile(File(profile.path));

      url = await ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .update({'image': url});
      // ignore: empty_catches
    } catch (e) {}
  }
}
