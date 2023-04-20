import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wood_mart/consts/consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
//text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

// signin method

  Future<UserCredential?> signinMethod({context}) async {
    UserCredential? userCredential;

    try {
     userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }
// signup method

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
   userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//storing data method

  storeUserData({name, password, email}) async {
    DocumentReference store = firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
     'id': currentUser!.uid,
    });
  }

storeVendorData({name, password, email}) async {
    DocumentReference store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    store.set({
      'vendor_name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
     'id': currentUser!.uid,
    });
  }

  //signout method

  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
