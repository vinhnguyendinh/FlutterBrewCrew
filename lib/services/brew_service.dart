import 'package:brew_crew/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrewService {
  final CollectionReference brewCollectionRef =
      FirebaseFirestore.instance.collection('brews');

  final String uid;

  BrewService({this.uid});

  List<Brew> _createBrewListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((event) {
      final data = event.data();
      return Brew(
        name: data['name'] ?? '',
        sugars: data['sugars'] ?? '0',
        strength: data['strength'] ?? 100,
      );
    }).toList();
  }

  Brew _createBrewFromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();
    return Brew(
      name: data['name'] ?? '',
      sugars: data['sugars'] ?? '0',
      strength: data['strength'] ?? 100,
    );
  }

  // Update brew
  Future<void> updateBrew({String name, String sugars, int strength}) {
    return brewCollectionRef
        .doc(uid)
        .set({'name': name, 'sugars': sugars, 'strength': strength})
        .then((_) => {})
        .catchError((error) {
          print("Failed to add brew: $error");
        });
  }

  // Stream get brews
  Stream<List<Brew>> get brews {
    return brewCollectionRef.snapshots().map(_createBrewListFromQuerySnapshot);
  }

  // Stream get brew with uid
  Stream<Brew> get brewData {
    return brewCollectionRef
        .doc(uid)
        .snapshots()
        .map(_createBrewFromDocumentSnapshot);
  }
}
