

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signature/signature.dart';
import 'package:test_app/config/router/app_router.dart';
import 'package:test_app/domain/entities/empleado.dart';
import 'package:test_app/presentation/providers/data_provider.dart';
import 'package:test_app/presentation/providers/empleado_provider.dart';
import 'package:test_app/presentation/widgets/helpers/show_snackbar.dart';

class SignatureScreen extends ConsumerStatefulWidget {
  const SignatureScreen({super.key});

  @override
  SignatureScreenState createState() => SignatureScreenState();
}

class SignatureScreenState extends ConsumerState<SignatureScreen> {
  // Crea un controlador para la firma
  final SignatureController _controller = SignatureController(
    penColor: Colors.black, // Color del bolígrafo
    penStrokeWidth: 5,      // Grosor del trazo
    exportBackgroundColor: Colors.white, // Color de fondo al exportar
  );

  // Función para borrar la firma
  void _clearSignature() {
    _controller.clear();
  }

  // Función para guardar la firma en formato de imagen
  Future<void> _saveSignature() async {
    final signature = await _controller.toImage();
    ejecutarMensaje(context, 'Empleado guardado');
    _clearSignature();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tu firma',style: textStyle.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 35,
          ),),
          const Divider(),
          Signature(
            controller: _controller,
            height: 200, // Altura del área de la firma
            width: MediaQuery.of(context).size.width,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón para borrar la firma
              FilledButton(
                onPressed: _clearSignature,
                child: const Text('Borrar'),
              ),
              const SizedBox(width: 20),
              // Botón para guardar la firma
              OutlinedButton(
                onPressed: () {
                  _saveSignature();
                  final newEmplado = 
                  Empleado(
                    id: 0, 
                    nombre: ref.read(nombreProvider), 
                    apellido: ref.read(apellidoProvider), 
                    cedula: ref.read(cedulaProvider), 
                    firma: ref.read(apellidoProvider), 
                    area: ref.read(areaProvider), 
                    cargo: ref.read(cargoProvider)
                  );
                  ref.read(empleadosProvider.notifier).save(newEmplado);
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
      
  }
}
