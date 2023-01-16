class product {
  int? id;
  String? title;
  String? date;
  String? image;
  int? marketPrice;
  int? sellingPrice;
  String? description;
  Category? category;
  bool? favourite;

  product(
      {this.id,
      this.title,
      this.date,
      this.image,
      this.marketPrice,
      this.sellingPrice,
      this.description,
      this.category,
      this.favourite});

  product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    image = json['image'];
    marketPrice = json['market_price'];
    sellingPrice = json['selling_price'];
    description = json['description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    favourite = json['favourite'];
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
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['favourite'] = this.favourite;
    return data;
  }
}

class Category {
  int? id;
  String? title;
  String? date;

  Category({this.id, this.title, this.date});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    return data;
  }
}
