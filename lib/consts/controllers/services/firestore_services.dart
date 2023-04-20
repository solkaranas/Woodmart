import 'package:wood_mart/consts/consts.dart';

class FirestoreServices {
  static getUser(uid) {
    // get users data
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // get products according to category

  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  // get cart

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete document

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static allProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

// get featured prodct
  static getFeaturedProduct() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  static searchProducts(title) {
    return firestore
        .collection(productsCollection)
        
        .get();
  }
}
