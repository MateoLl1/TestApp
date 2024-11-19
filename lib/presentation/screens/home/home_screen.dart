import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/presentation/providers/data_provider.dart';
import 'package:test_app/presentation/screens/firma/signature_screen.dart';
import 'package:test_app/presentation/screens/painters/home_painter.dart';
import 'package:test_app/presentation/widgets/helpers/validar_cedula.dart';
import 'package:test_app/presentation/widgets/textformfield/custom_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Agrega el controlador de página
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CustomPaint(
            painter: HomePainter(color: colors.primary),
            child: PageView(
              // physics: const NeverScrollableScrollPhysics(),
              controller: _pageController, // Asocia el controlador de página
              children: [
                FormHome1(pageController: _pageController),
                FormView3(pageController: _pageController,),
                const SignatureScreen()
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); 
    super.dispose();
  }
}

class FormHome1 extends ConsumerStatefulWidget {
  final PageController pageController;

  const FormHome1({super.key, required this.pageController});

  @override
  FormHome1State createState() => FormHome1State();
}

class FormHome1State extends ConsumerState<FormHome1> {
  final _nameFocusNode = FocusNode();
  final _lastnameFocusNode = FocusNode();
  final _cedulaFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registrar Empleado',
              style: textStyle.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 35,
              ),
            ),
            const Divider(),
            const Text('Ingrese los datos personales de su nuevo empleado'),
            const SizedBox(height: 20),
            CustomTextFormField(
              label: 'Nombre',
              hintText: 'John',
              icon: Icons.person,
              focusNode: _nameFocusNode,
              validator: (value) {
                if(value!.trim().isEmpty) return 'Campo requerido';
                return null;
              },
              onChanged: (value) {
                ref.read(nombreProvider.notifier).state = value;
                _formKey.currentState?.validate();
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Apellido',
              hintText: 'Doe',
              icon: Icons.person_2_outlined,
              focusNode: _lastnameFocusNode,
              onChanged: (value) {
                ref.read(apellidoProvider.notifier).state = value;
                _formKey.currentState?.validate();
              },
              validator: (value) {
                if(value!.trim().isEmpty) return 'Campo requerido';
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Cedula',
              textFormType: TextInputType.number,
              hintText: 'Ejm: 1756147899',
              icon: Icons.edit_document,
              focusNode: _cedulaFocusNode,
              validator: validarCedulaEcuatoriana,
              onChanged: (value) {
                ref.read(cedulaProvider.notifier).state = value;
                _formKey.currentState?.validate();
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {
        
                  final isValid = _formKey.currentState?.validate();
                  if(!isValid!) return;
                  // MOVIEMIENTO
                  widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
        
                  
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Siguiente'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormView3 extends ConsumerStatefulWidget {
  final PageController pageController;
  const FormView3({super.key, required this.pageController});

  @override
  FormView3State createState() => FormView3State();
}

class FormView3State extends ConsumerState<FormView3> {
  final _formKey = GlobalKey<FormState>(); 
  String? _selectedCargo;
  String? _selectedArea;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      child: Form( // Agregamos el Form widget para validación
        key: _formKey, // Asignamos la clave para la validación
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tipo de empleado',
              style: textStyle.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 35,
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),

            // Dropdown para Cargo
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Cargo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.work),
              ),
              value: _selectedCargo, // Asignamos el valor seleccionado
              items: const [
                DropdownMenuItem(value: 'Supervisor', child: Text('Supervisor')),
                DropdownMenuItem(value: 'Líder', child: Text('Líder')),
                DropdownMenuItem(value: 'Operario', child: Text('Operario')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCargo = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione un cargo';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            // Dropdown para Área
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Área',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.apartment),
              ),
              value: _selectedArea, // Asignamos el valor seleccionado
              items: const [
                DropdownMenuItem(value: 'Financiera', child: Text('Financiera')),
                DropdownMenuItem(value: 'Talento Humano', child: Text('Talento Humano')),
                DropdownMenuItem(value: 'Operaciones', child: Text('Operaciones')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedArea = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione un área';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 20),

            // Botón "Siguiente"
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ref.read(cargoProvider.notifier).state = _selectedCargo!;
                    ref.read(areaProvider.notifier).state = _selectedArea!;

                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    // Si no es válido, muestra un mensaje o hace algo según sea necesario
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Por favor complete todos los campos')),
                    );
                  }
                },
                child: const Text('Siguiente'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
