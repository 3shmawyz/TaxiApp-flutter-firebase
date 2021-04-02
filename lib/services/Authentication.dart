import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final _firedb = FirebaseDatabase.instance;

  singup(String email, String password, String name, String phone) async {
    final UserCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (UserCredential != null) {
      DatabaseReference newUseref =
          _firedb.reference().child('users/${UserCredential.user.uid}');
      Map userMap = 
      {'fullName': name,
       'email': email,
        'phone': phone};
      newUseref.set(userMap);
    }
  }
  login(String email , String password)async{
    final UserCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
