import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FireStoreServices {
  var user = FirebaseFirestore.instance.collection('Messages');

  Future<void> sendMessage({
    required String message,
    required String sender,
    required String selectedChat,
    required int userCount,
    required String userCountN,
  }) async {
    // a function to store a message in firestore collection
    bool result = false;
    try {
      String docId = '';
      await user.doc(selectedChat).collection('Messages_list').add(
        {
          'message': message,
          'sender': sender,
          'time': DateTime.now(),
          'read': false,
          'message_id': '',
          'created': DateTime.now(),
          'updated': DateTime.now(),
        },
      ).then(
        (value) {
          docId = value.id;
          result = true;
        },
      ).catchError(
        (e) {
          result = false;
          Get.snackbar('Error occured', e);
        },
      );

      if (result) {
        await user
            .doc(selectedChat)
            .collection('Messages_list')
            .doc(docId)
            .update({'message_id': docId});
        print('${sender}_count');
        await user.doc(selectedChat).update({userCountN: userCount + 1});
      }
    } catch (e) {
      Get.snackbar('Error occured', e.toString());
    }
  }

  Future<void> deleteChat({required String chatId}) async {
    // a function to delete the selected chat from firestore
    await user.doc(chatId).delete().then(
      (value) {
        Get.back();
        Get.showSnackbar(
            GetSnackBar(title: 'Success', message: 'your chat was deleted'));
      },
    ).catchError(
      (e) {
        Get.snackbar('Error', e);
      },
    );
  }
}

String timeStampToDate(Timestamp time) {
  // Function that take a Timestamp and return a date (YYYY/MM/DD)
  String date = time.toDate().year.toString() +
      '/' +
      time.toDate().month.toString().padLeft(2, '0') +
      '/' +
      time.toDate().day.toString().padLeft(2, '0');
  return date;
}

String timeStampToTime(Timestamp time) {
  // Function that take a Timestamp and return a Time (HH:MM)
  String hour = time.toDate().hour.toString().padLeft(2, '0') +
      ':' +
      time.toDate().minute.toString().padLeft(2, '0');
  return hour;
}
