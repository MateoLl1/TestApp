import 'package:flutter/material.dart';
import 'package:test_app/presentation/screens/painters/home_painter.dart';
import 'package:test_app/presentation/widgets/helpers/show_snackbar.dart';
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
              controller: _pageController, // Asocia el controlador de página
              children: [
                FormHome1(pageController: _pageController),
                const FormView3(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); // Libera el controlador al finalizar
    super.dispose();
  }
}

class FormHome1 extends StatefulWidget {
  final PageController pageController;

  const FormHome1({super.key, required this.pageController});

  @override
  State<FormHome1> createState() => _FormHome1State();
}

class _FormHome1State extends State<FormHome1> {
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
              hintText: 'Ejm: 1756147899',
              icon: Icons.edit_document,
              focusNode: _cedulaFocusNode,
              validator: validarCedulaEcuatoriana,
              onChanged: (value) {
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

class FormView3 extends StatefulWidget {
  const FormView3({super.key});

  @override
  State<FormView3> createState() => _FormView3State();
}

class _FormView3State extends State<FormView3> {

  


  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
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
          
          const SizedBox(height: 10),

          // Dropdown para Cargo
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Cargo',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.work),
            ),
            items: const [
              DropdownMenuItem(value: 'Supervisor', child: Text('Supervisor')),
              DropdownMenuItem(value: 'Líder', child: Text('Líder')),
              DropdownMenuItem(value: 'Operario', child: Text('Operario')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),

          // Dropdown para Área
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Área',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.apartment),
            ),
            items: const [
              DropdownMenuItem(value: 'Financiera', child: Text('Financiera')),
              DropdownMenuItem(value: 'Talento Humano', child: Text('Talento Humano')),
              DropdownMenuItem(value: 'Operaciones', child: Text('Operaciones')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),

          
          const SizedBox(height: 20),
          
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: (){
                ejecutarMensaje(context, 'Empleado registrado');

              }, 
              child: const Text('Guardar'),
            
            ),
          )
        ],
      ),
    );
  }
}

