

import 'package:flutter/material.dart';

void ejecutarMensaje(BuildContext context,String mensaje){
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(mensaje)
    )
  );
}