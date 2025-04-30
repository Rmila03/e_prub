import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Pedidos Activos'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3, // Ejemplo con 3 pedidos
        itemBuilder: (context, index) {
          return _OrderCard(
            orderNumber: 'PED-${index + 1}',
            service: 'Impresión 3D',
            client: 'Cliente ${index + 1}',
            status: 'En producción',
            deliveryDate: '15/03/2024',
            onUpdateStatus: () {
              _showStatusDialog(context);
            },
            onUploadFiles: () {
              _showUploadDialog(context);
            },
          );
        },
      ),
    );
  }

  void _showStatusDialog(BuildContext context) {
    String selectedStatus = 'En producción';
    String? trackingCode;
    bool showPhotoUpload = false;
    bool showTrackingCode = false;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(
                    'Actualizar Estado',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedStatus,
                        decoration: InputDecoration(
                          labelText: 'Estado del pedido',
                          labelStyle: TextStyle(
                            color: AppColors.textPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'En producción',
                            child: Text('En producción'),
                          ),
                          DropdownMenuItem(
                            value: 'Listo para envío',
                            child: Text('Listo para envío'),
                          ),
                          DropdownMenuItem(
                            value: 'Completado',
                            child: Text('Completado'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value!;
                            showPhotoUpload = value == 'Listo para envío';
                            showTrackingCode = value == 'Completado';
                          });
                        },
                      ),
                      if (showPhotoUpload) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Por favor, sube una foto del producto terminado:',
                          style: TextStyle(color: AppColors.textPrimaryColor),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Aquí iría la lógica para seleccionar y subir la foto
                          },
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Subir Foto'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                      if (showTrackingCode) ...[
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Código de seguimiento',
                            labelStyle: TextStyle(
                              color: AppColors.textPrimaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            trackingCode = value;
                          },
                        ),
                      ],
                      const SizedBox(height: 16),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Notas (opcional)',
                          labelStyle: TextStyle(
                            color: AppColors.textPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedStatus == 'Listo para envío' &&
                            !showPhotoUpload) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Debes subir una foto del producto',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        if (selectedStatus == 'Completado' &&
                            (trackingCode == null || trackingCode!.isEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Debes ingresar el código de seguimiento',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Estado actualizado'),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Actualizar'),
                    ),
                  ],
                ),
          ),
    );
  }

  void _showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              'Subir Archivos',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Selecciona los archivos a subir:',
                  style: TextStyle(color: AppColors.textPrimaryColor),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Aquí iría la lógica para seleccionar y subir archivos
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Seleccionar Fotos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // Aquí iría la lógica para seleccionar y subir archivos
                  },
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Seleccionar Archivos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Archivos subidos exitosamente'),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Subir'),
              ),
            ],
          ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String orderNumber;
  final String service;
  final String client;
  final String status;
  final String deliveryDate;
  final VoidCallback onUpdateStatus;
  final VoidCallback onUploadFiles;

  const _OrderCard({
    required this.orderNumber,
    required this.service,
    required this.client,
    required this.status,
    required this.deliveryDate,
    required this.onUpdateStatus,
    required this.onUploadFiles,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.primaryColor, width: 1),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderNumber,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _OrderInfoItem(
              icon: Icons.build,
              title: 'Servicio',
              value: service,
            ),
            const SizedBox(height: 8),
            _OrderInfoItem(icon: Icons.person, title: 'Cliente', value: client),
            const SizedBox(height: 8),
            _OrderInfoItem(
              icon: Icons.calendar_today,
              title: 'Fecha de entrega',
              value: deliveryDate,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onUpdateStatus,
                  icon: const Icon(Icons.update),
                  label: const Text('Actualizar Estado'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En producción':
        return AppColors.primaryColor;
      case 'Listo para envío':
        return AppColors.secondaryColor;
      case 'Completado':
        return AppColors.successColor;
      default:
        return AppColors.textPrimaryColor;
    }
  }
}

class _OrderInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _OrderInfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primaryColor),
        const SizedBox(width: 8),
        Text(
          '$title: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppColors.textPrimaryColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
