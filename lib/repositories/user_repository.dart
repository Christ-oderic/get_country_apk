import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_country_apk/model/user_model.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({
    FirebaseAuth? firebaseAuth, 
    FirebaseFirestore? firestore
    }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;


  Future<UserModel?> singUp({
    required String email,
    required String password,
    required String username
  }) async {
    try {

      // Créer l'utilisateur dans  la basse de données avec Firebase Auth
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password      
      );

      // Créer un UserModel
      final UserModel newUser = UserModel(
        id: userCredential.user!.uid,
        username: username,
        password: '',
        createdAt: DateTime.now(),
        email: email,
        profilePictureUrl: "",
        accountStatus: true
      );

      // Sauvegarder l'utilisateur dans Firestore
      await _firestore
        .collection('users')
        .doc(newUser.id)
        .set(newUser.toFirestore());
      return newUser;
    } catch (e) {
      print("Erreur lors de l\'inscription: $e");
      return null;
    }
  }

  Future<UserModel?> singIn({
    required String email,
    required String password
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      // Récupérer les informations complète de l'utilisateur depuis Firestore
      final userDoc = await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

      return UserModel.fromFirestore(userDoc.data()!); 

    } catch (e) {
      print("Erreur lors de la connexion: $e");
      return null;
    }
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> getCurrentUserToken() async {
    return await _firebaseAuth.currentUser?.getIdToken();
  }

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

}