import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pocket_of_peace/model/quiz_data_model.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveQuizData(List<CardDetail> cardDetails) async {
    try {
      String formattedDate =
          DateFormat('yyyy MMMM dd, hh:mm a').format(DateTime.now());
      final collection = firestore.collection('quiz_data');
      final document = collection.doc(); // Creates a new document reference
      await document.set({
        'card_details': cardDetails.map((detail) => detail.toJson()).toList(),
        'createdAt': formattedDate,
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
