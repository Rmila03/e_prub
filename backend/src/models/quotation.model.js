const mongoose = require('mongoose');

const fileSchema = new mongoose.Schema({
  name: { type: String, required: true },
  url: { type: String, required: true },
  type: { type: String, required: true },
});

const quotationSchema = new mongoose.Schema({
  clientId: { type: String, required: true },
  serviceType: { 
    type: String, 
    required: true,
    enum: ['Impresión 3D', 'Corte Láser', 'Manufactura', 'Servicios Especiales']
  },
  description: { type: String, required: true },
  files: [fileSchema],
  status: {
    type: String,
    required: true,
    enum: ['Pendiente', 'Aceptada', 'Rechazada'],
    default: 'Pendiente'
  },
  requestedDate: { type: Date, required: true },
  deliveryDate: { type: Date, required: true },
  price: { type: Number },
  notes: String,
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now }
});

// Middleware para actualizar updatedAt antes de guardar
quotationSchema.pre('save', function(next) {
  this.updatedAt = new Date();
  next();
});

module.exports = mongoose.model('Quotation', quotationSchema); 