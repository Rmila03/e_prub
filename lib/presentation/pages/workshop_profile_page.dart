import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class WorkshopProfilePage extends StatefulWidget {
  const WorkshopProfilePage({super.key});

  @override
  State<WorkshopProfilePage> createState() => _WorkshopProfilePageState();
}

class _WorkshopProfilePageState extends State<WorkshopProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isValidated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Perfil del Taller'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información Básica
              const Text(
                'Información Básica',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Nombre del Taller',
                icon: Icons.business,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'RUC',
                icon: Icons.assignment,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Descripción del Taller',
                icon: Icons.description,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Capacidad y Herramientas
              const Text(
                'Capacidad y Herramientas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Área de Trabajo (m²)',
                icon: Icons.square_foot,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Número de Empleados',
                icon: Icons.people,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Herramientas Disponibles',
                icon: Icons.build,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Ubicación
              const Text(
                'Ubicación',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Dirección',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              const CustomTextField(label: 'Ciudad', icon: Icons.location_city),
              const SizedBox(height: 16),
              const CustomTextField(label: 'Distrito', icon: Icons.map),
              const SizedBox(height: 24),

              // Fotos de Instalaciones
              const Text(
                'Fotos de Instalaciones',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 50,
                        color: AppColors.secondaryColor.withValues(alpha: 125),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Agregar fotos',
                        style: TextStyle(
                          color: AppColors.secondaryColor.withValues(
                            alpha: 125,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Estado de Validación
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      _isValidated
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isValidated ? Icons.verified : Icons.pending,
                      color: _isValidated ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _isValidated
                            ? 'Taller validado y verificado'
                            : 'Taller en proceso de validación',
                        style: TextStyle(
                          color: _isValidated ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Botón de Guardar
              CustomButton(
                text: 'Guardar Cambios',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí iría la lógica para guardar los cambios
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cambios guardados exitosamente'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
