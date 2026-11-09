import 'package:pedidos_app/domain/entities/pedido.dart';

abstract class PedidoRepositoryContract {
  Future<List<Pedido>> getPedidos();
  Future<Pedido> createPedido(CreatePedidoRequest request);
}

class CreatePedidoRequest {
  final String usuarioId;
  final List<String> items;
  final double total;

  CreatePedidoRequest({
    required this.usuarioId,
    required this.items,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'items': items,
      'total': total,
    };
  }
}