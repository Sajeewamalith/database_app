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

  Product _selectedProduct;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ProductDBHelper.instance.getProductsList().then((value) {
      setState(() {
        productList = value;
      });
    });
  }

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
                                return GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3,
                                          spreadRadius: 3,
                                          color: Colors.grey.withOpacity(0.2)
                                        )
                                      ]
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.all_inbox),
                                      title: Text(productList[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      subtitle: Text('LKR ${productList[index].price}',
                                        style: TextStyle(fontSize: 15),),
                                      trailing: Container(
                                        width: 100,
                                        child: Wrap(
                                           direction: Axis.horizontal,
                                          children: [
                                            IconButton(icon: Icon(Icons.edit), onPressed: (){
                                                setState(() {
                                                   _selectedProduct = productList[index];
                                                   showProductDialogBox(context , InputType.UpdateProduct);
                                                });
                                            }),
                                            ////////////// Delete Icon..........
                                            IconButton( icon: Icon(Icons.delete,
                                              color: Colors.red,),
                                              onPressed: (){
                                              setState(() {
                                                _selectedProduct = productList[index];
                                              });
                                              ProductDBHelper.instance.
                                              deleteProduct(_selectedProduct).then((value) {
                                                ProductDBHelper.instance.getProductsList().then((value) {
                                                  setState(() {
                                                    productList = value;
                                                  });
                                                });
                                              });
                                              }
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                           }else{
                             return Container(
                                 child: Center(child: Text('List is empty'),),
                             );
                           }
                     }))
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          _emptyTextFields();
          showProductDialogBox(context , InputType.AddProduct);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  //////// Show product dialog box......... Name , price , quantity ........
  showProductDialogBox(BuildContext context , InputType type)
  {
    bool isUpdateProduct = false;

    isUpdateProduct = (type == InputType.UpdateProduct) ? true : false;

    if(isUpdateProduct){
           _nameController.text = _selectedProduct.name;
           _priceController.text = _selectedProduct.price;
           _quantityController.text = _selectedProduct.quantity.toString();
    }

    Widget saveButton = TextButton(onPressed: (){
      if(_nameController.text.isNotEmpty && _priceController.text.isNotEmpty
          && _quantityController.text.isNotEmpty){




/////////////// Add new Product .............

        if(!isUpdateProduct){

          setState(() {
            Product product = Product();
            Product.name = _nameController.text;
            Product.price = _priceController.text;
            Product.quantity = int.parse(_quantityController.text);

          ProductDBHelper.instance.insertProduct(product).then((value) {

            ////////////// Refresh products list ...............
            ProductDBHelper.instance.getProductsList().then((value) {

              this.setState(() {
                productList = value;
              });
            });

            Navigator.pop(context);
            _emptyTextFields();
          });
          });
        }
        /////////////// Update product ..............
        else{

          setState(() {

            _selectedProduct.name = _nameController.text;
            _selectedProduct.price = _priceController.text;
            _selectedProduct.quantity = int.parse(_quantityController.text);

            ProductDBHelper.instance.updateProduct(_selectedProduct).then((value) {

              ////////////// Refresh products list ...............
              ProductDBHelper.instance.getProductsList().then((value) {

                this.setState(() {
                  productList = value;
                });
              });

              Navigator.pop(context);
              _emptyTextFields();
            });
          });



        }

        });


      }
    },child: Text('Save'));
    Widget cancelButton = TextButton(onPressed: (){
      Navigator.of(context).pop();
    },child: const Text('Cancel'));

    AlertDialog productDetailBox = AlertDialog(
      title: Text(!isUpdateProduct ? 'Add new product': 'Update Product'),
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
  void _emptyTextFields(){
       _nameController.text = '';
       _priceController.text = '';
       _quantityController.text = '';
  }
}

enum InputType{AddProduct , UpdateProduct}