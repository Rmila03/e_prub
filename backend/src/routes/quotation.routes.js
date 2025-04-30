const express = require('express');
const router = express.Router();
const { body, param } = require('express-validator');
const quotationController = require('../controllers/quotation.controller');
const authMiddleware = require('../middleware/auth.middleware');
const uploadMiddleware = require('../middleware/upload.middleware');

// Middleware de validación
const validateQuotation = [
  body('serviceType').isIn(['Impresión 3D', 'Corte Láser', 'Manufactura', 'Servicios Especiales']),
  body('description').notEmpty(),
  body('deliveryDate').isISO8601(),
];

// Rutas públicas
router.get('/', authMiddleware, quotationController.getAllQuotations);
router.get('/:id', authMiddleware, quotationController.getQuotationById);

// Rutas protegidas
router.post(
  '/',
  authMiddleware,
  uploadMiddleware.array('files'),
  validateQuotation,
  quotationController.createQuotation
);

router.put(
  '/:id',
  authMiddleware,
  validateQuotation,
  quotationController.updateQuotation
);

router.post(
  '/:id/accept',
  authMiddleware,
  [param('id').isMongoId(), body('price').isNumeric()],
  quotationController.acceptQuotation
);

router.post(
  '/:id/reject',
  authMiddleware,
  [param('id').isMongoId(), body('reason').notEmpty()],
  quotationController.rejectQuotation
);

module.exports = router; 