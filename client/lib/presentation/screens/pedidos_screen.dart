import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/pedido.dart';
import '../../domain/usecases/get_pedidos.dart';
import '../../data/repositories/pedido_repository.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({super.key});

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  List<Pedido> _pedidos = [];
  bool _isLoading = false;
  String? _errorMessage;
  PedidoRepository? _repository;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndLoad();
    });
  }

  Future<void> _initializeAndLoad() async {
    _repository ??= Provider.of<PedidoRepository>(context, listen: false);
    await loadPedidos();
  }

  Future<void> loadPedidos() async {
    if (_repository == null) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final getPedidosUseCase = GetPedidos(_repository!);
      final pedidos = await getPedidosUseCase();
      setState(() {
        _pedidos = pedidos;
        _isLoading = false;
      });
    } on PedidoRepositoryException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error inesperado al cargar pedidos.';
        _isLoading = false;
      });
    }
  }

  Future<void> _createPedido() async {
    if (_repository == null) return;

    final request = CreatePedidoRequest(
      usuarioId: 'usuario_001',
      items: ['Producto A', 'Producto B'],
      total: 150.00,
    );

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final createPedidoUseCase = CreatePedido(_repository!);
      final nuevoPedido = await createPedidoUseCase(request);
      setState(() {
        _pedidos = [..._pedidos, nuevoPedido];
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pedido ${nuevoPedido.id} creado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on PedidoRepositoryException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error inesperado al crear pedido.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : loadPedidos,
            tooltip: 'Actualizar pedidos',
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _createPedido,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Pedido'),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _pedidos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando pedidos...'),
          ],
        ),
      );
    }

    if (_errorMessage != null && _pedidos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: loadPedidos,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (_pedidos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No tienes pedidos aún',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Toca el botón + para crear tu primer pedido',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        if (_errorMessage != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.red.shade50,
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.red.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _errorMessage = null),
                ),
              ],
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: loadPedidos,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _pedidos.length,
              itemBuilder: (context, index) {
                return _PedidoCard(
                  pedido: _pedidos[index],
                  onTap: () => _showPedidoDetalle(_pedidos[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showPedidoDetalle(Pedido pedido) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Pedido #${pedido.id}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                _DetailRow(label: 'Estado', value: pedido.estado),
                _DetailRow(label: 'Total', value: '\$${pedido.total.toStringAsFixed(2)}'),
                _DetailRow(
                  label: 'Fecha', 
                  value: '${pedido.fechaCreacion.day}/${pedido.fechaCreacion.month}/${pedido.fechaCreacion.year}',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Items:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...pedido.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(item),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PedidoCard extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback onTap;

  const _PedidoCard({
    required this.pedido,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido #${pedido.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _EstadoBadge(estado: pedido.estado),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Usuario: ${pedido.usuarioId}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${pedido.items.length} items',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    '\$${pedido.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _formatDate(pedido.fechaCreacion),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _EstadoBadge extends StatelessWidget {
  final String estado;

  const _EstadoBadge({required this.estado});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    
    switch (estado.toLowerCase()) {
      case 'completado':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'pendiente':
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;
      case 'cancelado':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 'procesando':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        estado,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}