
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/filter.dart';

final firebaseProvider = Provider<FirebaseService>((ref) => FirebaseService());

class FirebaseService {
  final _fireStore = FirebaseFirestore.instance;
  updateArrayElements(String path, String id, String field, dynamic data) async {
    if (data is List) {
      await _fireStore.collection(path).doc(id).update({
        field: FieldValue.arrayUnion(data)
      });
    } else if (data is Map<String, dynamic>) {
      await _fireStore.collection(path).doc(id).update({
        field: FieldValue.arrayUnion([data])
      });
    } else {
      throw ArgumentError('data must be either a List or a Map<String, dynamic>');
    }
  }
  removeArrayElement(String path, String id, String attribute, dynamic data) async {
    if (data is List) {
      await _fireStore.collection(path).doc(id).update({
        attribute: FieldValue.arrayRemove(data)
      });
    }
    else if (data is Map<String, dynamic>) {
      await _fireStore.collection(path).doc(id).update({
        attribute: FieldValue.arrayRemove([data])
      });
    } else {
      throw ArgumentError('data must be either a List or a Map<String, dynamic>');
    }
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getDocuments(String collectionName) {
    return _fireStore.collection(collectionName).snapshots();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionDocuments(String collectionName, String id,String subCollectionPath,) {
    return _fireStore.collection(collectionName).doc(id).collection(subCollectionPath).snapshots();
  }


  Future<List<QueryDocumentSnapshot>> getFilteredHotels(HotelFilter filter, String collectionName) async {
    Query query = _fireStore.collection(collectionName);
    if (filter.instanConfirmation == true) {
      query = query.where('instanConfirmation', isEqualTo: filter.instanConfirmation);
    }
    if (filter.refundable == true) {
      query = query.where('refundable', isEqualTo: filter.refundable);
    }
    if (filter.allowPets == true) {
      query = query.where('allowPets', isEqualTo: filter.allowPets);
    }
    if (query != _fireStore.collection(collectionName)) {
      QuerySnapshot snapshot = await query.get();
      print("Number of documents fetched: ${snapshot.docs.length}");
      return snapshot.docs;
    } else {
      print("No filters applied, returning all documents.");
      QuerySnapshot snapshot = await _fireStore.collection(collectionName).get();
      return snapshot.docs;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? getDocumentById(String collectionName,String id)  {
   try{
     return  _fireStore.collection(collectionName).doc(id).snapshots();
   }catch(e){
     print(e.toString());
   }
   return null;
  }


  Future<void> createDocumentWithId(String collectionPath,String id, dynamic data) async {
    try{
      await _fireStore.collection(collectionPath).doc(id).set(data);
    } catch(e){
      print(e.toString());
    }
  }
  Future<void> createSubCollection(String collectionPath,String subCollectionPath,String id, dynamic data) async {
    try{
      await _fireStore.collection(collectionPath).doc(id).collection(subCollectionPath).add(data);
    } catch(e){
      print(e.toString());
    }
  }

  Future<void> updateDocument(String collectionPath, String docId, dynamic data) async {
    try{
      await _fireStore.collection(collectionPath).doc(docId).update(data);
    }catch(e){
      print(e.toString());
    }
  }

  Future<void> deleteDocument(String collectionPath, String docId) async {
    try{
      await _fireStore.collection(collectionPath).doc(docId).delete();
    }catch(e){
      print(e.toString());
    }
  }
}
