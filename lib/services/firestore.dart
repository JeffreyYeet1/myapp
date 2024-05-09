import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/services/model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Reads all documents from topics collection, returns a future which is a list of topics
  Future<List<Topic>> getTopics() async {
    // First thing to do is to make a reference to the collection we want to access
    var ref = _db.collection('topics');
    // Reads entire collection once. No listener on the collection
    var snapshot = await ref.get();
    // ref.get() contains extra meta data that we don't care about so we loop over each doc using map
    // and convert the snapshot into its raw data by calling its data method. s.data()
    var data = snapshot.docs.map((s) => s.data());
    // Data is a list of maps but we want a list of topics so we use that data to map it into a topic
    // using its fromJson function
    var topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  // Retrieves a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {} );
  }

  // Stream for listener to user report document
  Stream<Report> streamReport() {
    // Switch map is an rxdart extention that allows you to listen to one stream and then switch to another stream
    return AuthService().userStream.switchMap((user) {
      if(user!=null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }

  // Updates the current user's report document after submitting a quiz
  Future<void> updateUserReport(Quiz quiz){
    var user = AuthService().user!;
    var ref = _db.collection('reports').doc(user.uid);

    var data = {
      'total': FieldValue.increment(1),
      'topics': {
        // Map with a key of quiz topic and the value is the array of quiz ids taken for that topic
        quiz.topic: FieldValue.arrayUnion([quiz.id])
      }
    };

    // Can write to the data base using ref.set(data). setoptions(merge: true) makes it so that
    // this does not overwrite any existing data
    return ref.set(data, SetOptions(merge: true));
  }

}

