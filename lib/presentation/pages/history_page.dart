import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text('Historial'),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.textPrimaryColor.withOpacity(0.5),
            indicatorColor: AppColors.primaryColor,
            tabs: const [Tab(text: 'Cotizaciones'), Tab(text: 'Pedidos')],
          ),
        ),
        body: TabBarView(
          children: [_buildQuotationsList(), _buildOrdersList()],
        ),
      ),
    );
  }

  Widget _buildQuotationsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5, // Ejemplo con 5 cotizaciones
      itemBuilder: (context, index) {
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
                    Expanded(
                      child: Text(
                        'COT-${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getQuotationStatusColor(
                          'Aceptada',
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Aceptada',
                        style: TextStyle(
                          color: _getQuotationStatusColor('Aceptada'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: AppColors.primaryColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cliente ${index + 1}',
                        style: const TextStyle(
                          color: AppColors.textPrimaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '10/03/2024',
                      style: const TextStyle(color: AppColors.textPrimaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descripción:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Necesito imprimir una pieza de 10x10x10 cm en PLA',
                  style: const TextStyle(color: AppColors.textPrimaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Precio: S/ 150.00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Ver detalles
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                      ),
                      child: const Text('Ver detalles'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrdersList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5, // Ejemplo con 5 pedidos
      itemBuilder: (context, index) {
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
                    Expanded(
                      child: Text(
                        'PED-${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getOrderStatusColor(
                          'En proceso',
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'En proceso',
                        style: TextStyle(
                          color: _getOrderStatusColor('En proceso'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: AppColors.primaryColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cliente ${index + 1}',
                        style: const TextStyle(
                          color: AppColors.textPrimaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '15/03/2024',
                      style: const TextStyle(color: AppColors.textPrimaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descripción:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Impresión 3D de pieza en PLA',
                  style: const TextStyle(color: AppColors.textPrimaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Precio: S/ 150.00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Ver detalles
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                      ),
                      child: const Text('Ver detalles'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getQuotationStatusColor(String status) {
    switch (status) {
      case 'Pendiente':
        return AppColors.primaryColor;
      case 'Aceptada':
        return Colors.green;
      case 'Rechazada':
        return Colors.red;
      default:
        return AppColors.textPrimaryColor;
    }
  }

  Color _getOrderStatusColor(String status) {
    switch (status) {
      case 'En proceso':
        return AppColors.primaryColor;
      case 'Completado':
        return Colors.green;
      case 'Cancelado':
        return Colors.red;
      default:
        return AppColors.textPrimaryColor;
    }
  }
}
