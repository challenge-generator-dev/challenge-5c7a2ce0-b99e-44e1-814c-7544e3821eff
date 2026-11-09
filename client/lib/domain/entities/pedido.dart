import 'package:equatable/equatable.dart';

class Pedido extends Equatable {
  final String id;
  final String usuarioId;
  final List<String> items;
  final double total;
  final String estado;
  final DateTime fechaCreacion;

  const Pedido({
    required this.id,
    required this.usuarioId,
    required this.items,
    required this.total,
    required this.estado,
    required this.fechaCreacion,
  });

  @override
  List<Object?> get props => [id, usuarioId, items, total, estado, fechaCreacion];

  Pedido copyWith({
    String? id,
    String? usuarioId,
    List<String>? items,
    double? total,
    String? estado,
    DateTime? fechaCreacion,
  }) {
    return Pedido(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      items: items ?? this.items,
      total: total ?? this.total,
      estado: estado ?? this.estado,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }
}