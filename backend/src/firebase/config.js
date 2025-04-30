const admin = require('firebase-admin');
const config = require('../config/config');

admin.initializeApp({
  credential: admin.credential.cert(config.firebaseConfig),
  storageBucket: `${config.firebaseConfig.projectId}.appspot.com`,
});

const db = admin.firestore();
const storage = admin.storage();
const auth = admin.auth();

module.exports = {
  admin,
  db,
  storage,
  auth,
}; 