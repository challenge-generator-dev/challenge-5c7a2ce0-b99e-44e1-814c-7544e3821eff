import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pedidos_app/domain/usecases/get_pedidos.dart';
import 'package:pedidos_app/data/repositories/pedido_repository.dart';
import 'package:pedidos_app/presentation/screens/pedidos_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<PedidoRepository>(create: (_) => PedidoRepository()),
        ProxyProvider<PedidoRepository, GetPedidos>(
          update: (_, repository, __) => GetPedidos(repository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedidos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PedidosScreen(),
    );
  }
}