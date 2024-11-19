

import 'package:flutter/material.dart';
import 'package:test_app/presentation/screens/painters/home_painter.dart';
import 'package:test_app/presentation/widgets/textformfield/custom_text_form_field.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              children: const [
                FormHome1(),
                Placeholder(),

              ],
            ),
          )

        ],
      )
    );
  }
}


class FormHome1 extends StatefulWidget {
  const FormHome1({super.key});

  @override
  State<FormHome1> createState() => _FormHome1State();
}

class _FormHome1State extends State<FormHome1> {

  final _nameFocusNode = FocusNode();
  final _lastnameFocusNode = FocusNode();
  final _cedulaFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return  Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      
          Text(
            'Registrar Empleado',
            style: textStyle.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 35
            ),
          ),
          const Divider(),
          const Text('Ingrese los datos personales de su nuevo empleado'),
          const SizedBox(height: 20,),
          CustomTextFormField(
            label: 'Nombre',
            hintText: 'John',
            icon: Icons.person,
            focusNode: _nameFocusNode,
          ),

          const SizedBox(height: 10,),
          CustomTextFormField(
            label: 'Apellido',
            hintText: 'Doe',
            icon: Icons.person,
            focusNode: _lastnameFocusNode,
          ),
          const SizedBox(height: 10,),
          CustomTextFormField(
            label: 'Cedula',
            hintText: 'Ejm: 1756147899',
            icon: Icons.person,
            focusNode: _cedulaFocusNode,
          ),


          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  Text('Siguiente'),
                  SizedBox(width: 8), 
                  Icon(Icons.logout),
                ],
              ),
            ),
          ),

      
        ],
      ),
    );
  }
}
