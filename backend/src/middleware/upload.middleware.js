const multer = require('multer');
const path = require('path');

// Configuración de almacenamiento en memoria
const storage = multer.memoryStorage();

// Filtro de archivos
const fileFilter = (req, file, cb) => {
  const allowedTypes = [
    'application/pdf',
    'application/octet-stream', // Para archivos STL
    'image/jpeg',
    'image/png',
    'model/stl',
    'application/sla',
  ];
  
  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Tipo de archivo no permitido'), false);
  }
};

// Configuración de multer
const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 50 * 1024 * 1024, // 50MB máximo
  },
});

module.exports = upload; 