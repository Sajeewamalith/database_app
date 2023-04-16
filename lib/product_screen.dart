import 'package:database_app/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
      ),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          showProductDialogBox(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  showProductDialogBox(BuildContext context){

    Widget saveButton = TextButton(onPressed: (){
      if(_nameController.text.isNotEmpty && _priceController.text.isNotEmpty && _quantityController.text.isNotEmpty){

      }
    },child: Text('Save'));
    Widget cancelButton = TextButton(onPressed: (){
      Navigator.of(context).pop();
    },child: const Text('Cancel'));

    AlertDialog productDetailBox = AlertDialog(
      title: Text('Add new product'),
      content: Container(
        child: Wrap(
          children: [
            Container(
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name'
                ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Product Price'
                ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Product Quantity'
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        saveButton,
        cancelButton
      ],
    );
    showDialog(context: context, builder:(BuildContext context){
      return productDetailBox;
    });
  }
}
