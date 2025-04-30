const Quotation = require('../models/quotation.model');
const { storage } = require('../firebase/config');
const { validationResult } = require('express-validator');

class QuotationController {
  // Obtener todas las cotizaciones
  async getAllQuotations(req, res) {
    try {
      const quotations = await Quotation.find()
        .sort({ createdAt: -1 });
      res.json(quotations);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  }

  // Obtener una cotización por ID
  async getQuotationById(req, res) {
    try {
      const quotation = await Quotation.findById(req.params.id);
      if (!quotation) {
        return res.status(404).json({ message: 'Cotización no encontrada' });
      }
      res.json(quotation);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  }

  // Crear una nueva cotización
  async createQuotation(req, res) {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const files = await this.uploadFiles(req.files);
      
      const quotation = new Quotation({
        ...req.body,
        files,
        clientId: req.user.uid
      });

      const savedQuotation = await quotation.save();
      
      // Crear notificación en Firestore
      await this.createNotification(savedQuotation);
      
      res.status(201).json(savedQuotation);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  }

  // Actualizar una cotización
  async updateQuotation(req, res) {
    try {
      const quotation = await Quotation.findById(req.params.id);
      if (!quotation) {
        return res.status(404).json({ message: 'Cotización no encontrada' });
      }

      Object.assign(quotation, req.body);
      const updatedQuotation = await quotation.save();
      
      res.json(updatedQuotation);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  }

  // Aceptar una cotización
  async acceptQuotation(req, res) {
    try {
      const { price } = req.body;
      const quotation = await Quotation.findById(req.params.id);
      
      if (!quotation) {
        return res.status(404).json({ message: 'Cotización no encontrada' });
      }

      quotation.status = 'Aceptada';
      quotation.price = price;
      const updatedQuotation = await quotation.save();
      
      // Crear orden automáticamente
      await this.createOrder(updatedQuotation);
      
      res.json(updatedQuotation);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  }

  // Rechazar una cotización
  async rejectQuotation(req, res) {
    try {
      const { reason } = req.body;
      const quotation = await Quotation.findById(req.params.id);
      
      if (!quotation) {
        return res.status(404).json({ message: 'Cotización no encontrada' });
      }

      quotation.status = 'Rechazada';
      quotation.notes = reason;
      const updatedQuotation = await quotation.save();
      
      res.json(updatedQuotation);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  }

  // Métodos auxiliares
  async uploadFiles(files) {
    const uploadedFiles = [];
    
    for (const file of files) {
      const bucket = storage.bucket();
      const fileName = `${Date.now()}-${file.originalname}`;
      const fileUpload = bucket.file(fileName);

      const stream = fileUpload.createWriteStream({
        metadata: {
          contentType: file.mimetype,
        },
      });

      await new Promise((resolve, reject) => {
        stream.on('error', reject);
        stream.on('finish', resolve);
        stream.end(file.buffer);
      });

      const [url] = await fileUpload.getSignedUrl({
        action: 'read',
        expires: '03-01-2500',
      });

      uploadedFiles.push({
        name: file.originalname,
        url,
        type: file.mimetype,
      });
    }

    return uploadedFiles;
  }

  async createNotification(quotation) {
    const { db } = require('../firebase/config');
    await db.collection('notifications').add({
      type: 'new_quotation',
      quotationId: quotation._id,
      clientId: quotation.clientId,
      createdAt: new Date(),
      read: false,
    });
  }

  async createOrder(quotation) {
    const Order = require('../models/order.model');
    const order = new Order({
      quotationId: quotation._id,
      clientId: quotation.clientId,
      status: 'En proceso',
      estimatedTime: this.calculateEstimatedTime(quotation),
    });
    await order.save();
  }

  calculateEstimatedTime(quotation) {
    // Lógica para calcular el tiempo estimado basado en el tipo de servicio
    const timeEstimates = {
      'Impresión 3D': 24,
      'Corte Láser': 8,
      'Manufactura': 48,
      'Servicios Especiales': 72,
    };
    return timeEstimates[quotation.serviceType] || 24;
  }
}

module.exports = new QuotationController(); 