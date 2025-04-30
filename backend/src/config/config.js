require('dotenv').config();

module.exports = {
  // Configuración del servidor
  port: process.env.PORT || 3000,
  
  // Configuración de MongoDB
  mongoUri: process.env.MONGODB_URI || 'mongodb://localhost:27017/fabchain',
  
  // Configuración de Firebase
  firebaseConfig: {
    projectId: process.env.FIREBASE_PROJECT_ID,
    privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n'),
    clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
  },
  
  // Configuración de JWT
  jwtSecret: process.env.JWT_SECRET || 'tu-secret-key-segura',
  jwtExpiration: '24h',
  
  // Configuración de CORS
  corsOptions: {
    origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'],
  },
}; 