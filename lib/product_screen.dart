import 'package:database_app/product.dart';
import 'package:database_app/product_db_helper.dart';
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

  List<Product> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
      ),
      body: Center(
        child: Column(
          children: [
             Expanded(
                 child: ListView.builder(
                   itemCount: productList.length ,
                     itemBuilder: (BuildContext context,index){
                           if(productList.isNotEmpty){

                           }
                     }))
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

  //////// Show product dialog box......... Name , price , quantity ........
  showProductDialogBox(BuildContext context){

    Widget saveButton = TextButton(onPressed: (){
      if(_nameController.text.isNotEmpty && _priceController.text.isNotEmpty
          && _quantityController.text.isNotEmpty){

        Product product = Product();
        Product.name = _nameController.text;
        Product.price = _priceController.text;
        Product.quantity = int.parse(_quantityController.text);

        ProductDBHelper.instance.insertProduct(product).then((value) {
             ProductDBHelper.instance.getProductsList().then((value) {

               setState(() {
                    productList = value;
               });
             });
             Navigator.pop(context);
        });
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
