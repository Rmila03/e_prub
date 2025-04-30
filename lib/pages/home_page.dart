import 'package:flutter/material.dart';
import 'package:app_fabchain/core/theme/colors.dart';
import 'package:app_fabchain/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) async {
    final authService = AuthService();
    await authService.logout();
    // StreamBuilder en main.dart se encargará del redireccionamiento
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Fabchain'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bienvenido',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Fabchain App',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¡Bienvenido a FabChain!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'La red de fabricación descentralizada que conecta talleres y empresas en todo el mundo.',
              style: TextStyle(fontSize: 16, color: AppColors.textPrimaryColor),
            ),
            const SizedBox(height: 30),
            const Text(
              'Beneficios',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            _buildBenefits(),
            const SizedBox(height: 30),
            const Text(
              'Nuestro Proceso',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            _buildProcess(),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefits() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _benefitCard(Icons.handyman, 'Talleres Globales'),
        _benefitCard(Icons.access_time, 'Ahorro de Tiempo'),
        _benefitCard(Icons.attach_money, 'Reducción de Costos'),
      ],
    );
  }

  Widget _benefitCard(IconData icon, String title) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(icon, size: 40, color: AppColors.primaryColor),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProcess() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '1. Solicita tu Servicio',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Explora talleres, compara y elige el mejor.'),
            SizedBox(height: 20),
            Text(
              '2. Fabricación Personalizada',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Seguimos tu proyecto hasta el final con calidad garantizada.',
            ),
            SizedBox(height: 20),
            Text(
              '3. Entrega y Retroalimentación',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Recibe tu producto y ayuda a mejorar nuestra red.'),
          ],
        ),
      ),
    );
  }
}
