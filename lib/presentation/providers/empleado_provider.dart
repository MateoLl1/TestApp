

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_app/domain/entities/empleado.dart';


final empleadosProvider = StateNotifierProvider<EmpleadoNotifier,List<Empleado>>((ref) {
  return EmpleadoNotifier();
});


class EmpleadoNotifier extends StateNotifier<List<Empleado>> {
  EmpleadoNotifier(): super([]);
  
  Future<void> save(Empleado emp)async{
      state = [...state,emp];
  }
}