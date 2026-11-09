import 'package:pedidos_app/domain/entities/pedido.dart';
import 'package:pedidos_app/domain/repositories/pedido_repository_contract.dart';

class GetPedidos {
  final PedidoRepositoryContract repository;

  GetPedidos(this.repository);

  Future<List<Pedido>> call() async {
    try {
      final pedidos = await repository.getPedidos();
      if (pedidos.isEmpty) {
        throw Exception('No se encontraron pedidos');
      }
      return pedidos;
    } catch (e) {
      throw Exception('Error al obtener pedidos: $e');
    }
  }
}

class CreatePedido {
  final PedidoRepositoryContract repository;

  CreatePedido(this.repository);

  Future<Pedido> call(CreatePedidoRequest request) async {
    try {
      if (request.items.isEmpty) {
        throw Exception('La lista de items no puede estar vacía');
      }
      if (request.total <= 0) {
        throw Exception('El total debe ser mayor que cero');
      }
      return await repository.createPedido(request);
    } catch (e) {
      throw Exception('Error al crear pedido: $e');
    }
  }
}