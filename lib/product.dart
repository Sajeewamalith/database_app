

class Product{

  late int id;
  late String name;
  late String price;
  late int quantity;

  Product({required this.id , required this.name , required this.price , required this.quantity});

  ////// From map.......... Map=> Product object
  static Product fromMap(Map<String , dynamic> query){
   //  Product product = Product();
    ///// error fix
    Product product = Product.fromMap(Map<String, dynamic>.from(query));

    product.id = query['id'];
     product.name = query['name'];
     product.price = query['price'];
     product.quantity = query['quantity'];
     return product;
  }

  ///////// To Map ......... Product => Map
  static Map<String , dynamic> toMap(Product product){


     return <String , dynamic>{
         'id' : product.id,
          'name' : product.name,
          'price' : product.price,
          'quantity' : product.quantity,

     };
  }

  ////// From map list -------- Map List => Product List
  static List<Product> fromMapList(List<Map<String , dynamic>> query){

  //
    // List<Product> products = List<Product>();
    // fix error
    List<Product> products = [];
  //  for(Map mp in query){
  //    products.add(fromMap(mp));
  //  }
    // fix error
    for (Map<String, dynamic> mp in query) {
      products.add(fromMap(mp));
    }
    return products;
  }
}