class ProductsModel {
  final String pTitle;
  final String pSubtitle;
  final String imagePath;

  ProductsModel({
    required this.imagePath,
    required this.pTitle,
    required this.pSubtitle,
  });

  Map<String, dynamic> toJson() {
    return {
      "pTitle": pTitle,
      "pSubtitle": pSubtitle,
      'imagePath': imagePath,
    };
  }

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      pTitle: json["pTitle"],
      pSubtitle: json["pSubtitle"],
      imagePath: json["imagePath"],
    );
  }
}
