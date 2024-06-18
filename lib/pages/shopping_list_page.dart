import 'package:flutter/material.dart';
import '../models/shopping_item.dart';
import 'add_item_page.dart';


class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final List<ShoppingItem> _items = [];

  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddItemPage(
          onAddItem: (item) {
            setState(() {
              _items.add(item);
            });
          },
        ),
      ),
    );
  }

  void _editItem(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddItemPage(
          item: _items[index],
          onAddItem: (item) {
            setState(() {
              _items[index] = item;
            });
          },
        ),
      ),
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  double _calculateTotal() {
    return _items.fold(0, (sum, item) => sum + item.quantity * item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Quantidade: ${item.quantity}, Valor: ${item.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editItem(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteItem(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: ${_calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}