import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/pedido.dart';
import '../../domain/usecases/get_pedidos.dart';

abstract class PedidoRepositoryContract {
  Future<List<Pedido>> getPedidos();
  Future<Pedido> createPedido(CreatePedidoRequest request);
}

class PedidoRepository implements PedidoRepositoryContract {
  final http.Client _httpClient;
  final String _baseUrl;
  
  PedidoRepository({
    http.Client? httpClient,
    String? baseUrl,
  }) : _httpClient = httpClient ?? http.Client(),
       _baseUrl = baseUrl ?? const String.fromEnvironment(
         'API_BASE_URL',
         defaultValue: 'https://api.pedidos.example.com',
       );

  @override
  Future<List<Pedido>> getPedidos() async {
    try {
      final uri = Uri.parse('$_baseUrl/pedidos');
      final response = await _httpClient.get(
        uri,
        headers: _buildHeaders(),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw PedidoRepositoryException(
          'Tiempo de conexión agotado. Verifica tu conexión a internet.',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => _pedidoFromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw PedidoRepositoryException('No autorizado. Inicia sesión nuevamente.');
      } else if (response.statusCode == 404) {
        throw PedidoRepositoryException('Recurso no encontrado.');
      } else if (response.statusCode >= 500) {
        throw PedidoRepositoryException('Error del servidor. Intenta más tarde.');
      } else {
        throw PedidoRepositoryException(
          'Error al obtener pedidos. Código: ${response.statusCode}',
        );
      }
    } on PedidoRepositoryException {
      rethrow;
    } catch (e) {
      if (e.toString().contains('SocketException') || 
          e.toString().contains('HandshakeException')) {
        throw PedidoRepositoryException(
          'No se pudo conectar al servidor. Verifica tu conexión.',
        );
      }
      throw PedidoRepositoryException('Error inesperado: ${e.toString()}');
    }
  }

  @override
  Future<Pedido> createPedido(CreatePedidoRequest request) async {
    try {
      final uri = Uri.parse('$_baseUrl/pedidos');
      final response = await _httpClient.post(
        uri,
        headers: _buildHeaders(contentType: 'application/json'),
        body: json.encode(request.toJson()),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw PedidoRepositoryException(
          'Tiempo de conexión agotado. Verifica tu conexión a internet.',
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return _pedidoFromJson(jsonData);
      } else if (response.statusCode == 400) {
        final errorBody = json.decode(response.body);
        throw PedidoRepositoryException(
          errorBody['message'] ?? 'Datos inválidos. Verifica los campos.',
        );
      } else if (response.statusCode == 401) {
        throw PedidoRepositoryException('No autorizado. Inicia sesión nuevamente.');
      } else if (response.statusCode == 409) {
        throw PedidoRepositoryException('El pedido ya existe.');
      } else if (response.statusCode >= 500) {
        throw PedidoRepositoryException('Error del servidor. Intenta más tarde.');
      } else {
        throw PedidoRepositoryException(
          'Error al crear pedido. Código: ${response.statusCode}',
        );
      }
    } on PedidoRepositoryException {
      rethrow;
    } catch (e) {
      if (e.toString().contains('SocketException') || 
          e.toString().contains('HandshakeException')) {
        throw PedidoRepositoryException(
          'No se pudo conectar al servidor. Verifica tu conexión.',
        );
      }
      throw PedidoRepositoryException('Error inesperado: ${e.toString()}');
    }
  }

  Map<String, String> _buildHeaders({String? contentType}) {
    final headers = <String, String>{
      'Accept': 'application/json',
    };
    if (contentType != null) {
      headers['Content-Type'] = contentType;
    }
    return headers;
  }

  Pedido _pedidoFromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'] as String,
      usuarioId: json['usuarioId'] as String,
      items: List<String>.from(json['items'] ?? []),
      total: (json['total'] as num).toDouble(),
      estado: json['estado'] as String,
      fechaCreacion: DateTime.parse(json['fechaCreacion'] as String),
    );
  }

  void dispose() {
    _httpClient.close();
  }
}

class PedidoRepositoryException implements Exception {
  final String message;
  PedidoRepositoryException(this.message);
  
  @override
  String toString() => message;
}