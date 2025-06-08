importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyB7aQbzNeswUs11TSA2UxzKKrWX-Lzsnyo',
  appId: '1:402464264412:web:f275b2c4258b17d8ea6419',
  messagingSenderId: '402464264412',
  projectId: 'random-walk-app',
  authDomain: 'random-walk-app.firebaseapp.com',
  storageBucket: 'random-walk-app.firebasestorage.app',
  measurementId: 'G-YJPM0YS3N2',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});