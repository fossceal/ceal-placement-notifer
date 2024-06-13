importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
    apiKey: 'AIzaSyBEUwK9JWZPUEfs46P4kB1zusvHx744OuM',
    authDomain: 'placement-notifier-dcaaf.firebaseapp.com',
    databaseURL: 'https://placement-notifier-dcaaf.firebaseio.com',
    projectId: 'placement-notifier-dcaaf',
    storageBucket: 'placement-notifier-dcaaf.appspot.com',
    messagingSenderId: '723862345529',
    appId: '1:723862345529:web:cdbb1b7d4cee6dab163ae8',
    measurementId: 'G-37YDX9F1R2',
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});