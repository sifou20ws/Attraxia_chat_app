# Attraxia chat app

This Flutter project is a simple 2-screen chat application where each screen represents a different user. 

## Getting Started

To run the app, follow these steps:

1. Clone this repository to your local machine.

2. Open the project in your preferred IDE.

3. Ensure you have Flutter and Dart installed on your machine.

4. Choose one of the following options for Firebase setup:

   * Use My Pre-configured Firebase Project (start using the app directly).
      
   * Add Your Firebase Project:
      
     - Install Firebase CLI by following the installation instructions - https://firebase.google.com/docs/cli#setup_update_cli .
  
     - Log into Firebase using the Google account associated with your Firebase project by running  `firebase login` .
  
     - Install the FlutterFire CLI by running  `dart pub global activate flutterfire_cli`.
  
     - Run `flutterfire configure` and follow the steps in the workflow, making sure to select your Firebase project.
  
     - Enable the Cloud Firestore service in your Firebase project from the Firebase console.

5. Run the app on an emulator or physical device.

## Additional Informations

The database collection in this project is structured as follows :

# Messages collection
<img width="1250" alt="image" src="https://github.com/sifou20ws/Attraxia_chat_app/assets/84464555/9368e214-538b-4945-9677-ee211c0dbc37">
# Messages Subcollection
<img width="1156" alt="image" src="https://github.com/sifou20ws/Attraxia_chat_app/assets/84464555/882d562b-f81b-4fb0-a582-f392df4fbca6">


# Messages Collection
The messages collection stores all the chats within the application. Each document within this collection represents a unique chat and contains the following attributes:

* chat_name: The name of the chat.
* chat_id: The unique identifier for the chat document.
* created: Timestamp indicating the creation time of the chat.
* updated: Timestamp indicating the last updated time of the chat.
* user1_count: A counter representing the number of unread messages for User 1. When a message is sent from User 2, user1_count is incremented by 1. When navigating to User 1's screen, user1_count is set to 0, indicating that all messages have been viewed.
* user2_count: A counter representing the number of unread messages for User 2. When a message is sent from User 1, user2_count is incremented by 1. When navigating to User 2's screen, user2_count is set to 0, indicating that all messages have been viewed.
# Message Subcollection
Each chat document within the Messages collection contains a subcollection named Messages_list, which stores the individual messages exchanged within that chat. Each document within this subcollection represents a single message and contains the following attributes:

- message: The content of the message.
- time: Timestamp indicating the time the message was sent.
- read: A boolean indicating the read status of the message (used to show read status in the message bubble).
- sender: The sender of the message.
- message_id: The unique identifier for the message document.

Usage
When a new chat is created, a document is added to the `Messages` collection with the corresponding chat details. Each chat document includes counters to track unread messages for each user. These counters are updated in real-time as messages are sent and viewed by users. 
Each chat document includes a `messages_list` subcollection to store the individual messages exchanged within that chat. 
