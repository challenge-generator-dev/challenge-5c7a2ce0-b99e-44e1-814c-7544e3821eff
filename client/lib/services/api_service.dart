import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/entities/pedido.dart';
import '../domain/usecases/get_pedidos.dart';

class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<List<Pedido>> getPedidos() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/pedidos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => _pedidoFromJson(json)).toList();
      } else {
        throw ApiException(
          message: 'Error al obtener pedidos',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException(
        message: 'Error de conexión: ${e.message}',
        statusCode: null,
      );
    } on FormatException catch (e) {
      throw ApiException(
        message: 'Error al parsear respuesta: ${e.message}',
        statusCode: null,
      );
    }
  }

  Future<Pedido> createPedido(CreatePedidoRequest request) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/pedidos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return _pedidoFromJson(jsonData);
      } else {
        throw ApiException(
          message: 'Error al crear pedido',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException(
        message: 'Error de conexión: ${e.message}',
        statusCode: null,
      );
    } on FormatException catch (e) {
      throw ApiException(
        message: 'Error al parsear respuesta: ${e.message}',
        statusCode: null,
      );
    }
  }

  Pedido _pedidoFromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'] as String,
      usuarioId: json['usuarioId'] as String,
      items: List<String>.from(json['items'] as List),
      total: (json['total'] as num).toDouble(),
      estado: json['estado'] as String,
      fechaCreacion: DateTime.parse(json['fechaCreacion'] as String),
    );
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException: $message (Status: $statusCode)';
    }
    return 'ApiException: $message';
  }
}