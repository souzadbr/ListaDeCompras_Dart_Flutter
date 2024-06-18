import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../models/shopping_item.dart';

class AddItemPage extends StatefulWidget {
  final ShoppingItem? item;
  final Function(ShoppingItem) onAddItem;

  AddItemPage({this.item, required this.onAddItem});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = MoneyMaskedTextController(
    leftSymbol: "R\$ ", 
    decimalSeparator: ",",
    thousandSeparator: "." 
  );

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _quantityController.text = widget.item!.quantity.toString();
      _priceController.updateValue(widget.item!.price);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Adicionar Item' : 'Editar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome do Item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do item';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final item = ShoppingItem(
                      name: _nameController.text,
                      quantity: int.parse(_quantityController.text),
                      price: _priceController.numberValue,
                    );
                    widget.onAddItem(item);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.item == null ? 'Adicionar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
