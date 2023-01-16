class CartModel {
  int? id;
  int? total;
  bool? isComplete;
  String? date;
  int? user;
  List<Cartproducts>? cartproducts;

  CartModel(
      {this.id,
      this.total,
      this.isComplete,
      this.date,
      this.user,
      this.cartproducts});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    isComplete = json['isComplete'];
    date = json['date'];
    user = json['user'];
    if (json['cartproducts'] != null) {
      cartproducts = <Cartproducts>[];
      json['cartproducts'].forEach((v) {
        cartproducts!.add(new Cartproducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['isComplete'] = this.isComplete;
    data['date'] = this.date;
    data['user'] = this.user;
    if (this.cartproducts != null) {
      data['cartproducts'] = this.cartproducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cartproducts {
  int? id;
  int? price;
  int? quantity;
  int? subtotal;
  Cart? cart;
  List<Product>? product;

  Cartproducts(
      {this.id,
      this.price,
      this.quantity,
      this.subtotal,
      this.cart,
      this.product});

  Cartproducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int? id;
  int? total;
  bool? isComplete;
  String? date;
  int? user;

  Cart({this.id, this.total, this.isComplete, this.date, this.user});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    isComplete = json['isComplete'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['isComplete'] = this.isComplete;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}

class Product {
  int? id;
  String? title;
  String? date;
  String? image;
  int? marketPrice;
  int? sellingPrice;
  String? description;
  int? category;

  Product(
      {this.id,
      this.title,
      this.date,
      this.image,
      this.marketPrice,
      this.sellingPrice,
      this.description,
      this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    image = json['image'];
    marketPrice = json['market_price'];
    sellingPrice = json['selling_price'];
    description = json['description'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['image'] = this.image;
    data['market_price'] = this.marketPrice;
    data['selling_price'] = this.sellingPrice;
    data['description'] = this.description;
    data['category'] = this.category;
    return data;
  }
}
