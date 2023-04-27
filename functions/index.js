const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { BucketBuilder } = require('firebase-functions/v1/storage');
admin.initializeApp();

exports.sendNotificationOnFileUpload = functions.storage.object().onFinalize(async (object) => {
  const filePath = object.name;
  
  // Zugriff auf Benutzer-Authentifizierungs-Objekt
  const user = await admin.auth().getUser(object.metadata.uid);
  const userEmail = user.email;
  
  const userSnapshot = await admin.firestore().collection('users').where('Email', '==', userEmail).get();
  
  if (userSnapshot.empty) {
    console.log('No matching documents.');
    return;
  }

  const fcmToken = userSnapshot.docs[0].data().token;
  
  const offerFolder = 'files/' + userEmail + '/Angebot';
  if (filePath.startsWith(offerFolder)) {
    const payload = {
      notification: {
        title: 'Neue Datei hochgeladen',
        body: `Eine neue Datei wurde in den Ordner ${offerFolder} hochgeladen.`,
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };
    await admin.messaging().sendToDevice(fcmToken, payload);
  }
});
