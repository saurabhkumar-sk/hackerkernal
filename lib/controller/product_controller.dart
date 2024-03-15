import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackerkernel_assignment/models/productmodel_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Animation<double> get animation => _animation;

  final List<ProductsModel> _questions = [];
  List<ProductsModel> get questions => _questions;

  final List<ProductsModel> _filteredQuestion = [];
  List<ProductsModel> get filteredQuestion => _filteredQuestion;
  final TextEditingController questionContorllerText = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController correctAnswerController = TextEditingController();
  final TextEditingController quizCategory = TextEditingController();

  Future<void> saveQuestionToSharedPrefrences(
      ProductsModel productsModel) async {
    final prefs = await SharedPreferences.getInstance();
    final questions = prefs.getStringList("questions") ?? [];
    questions.add(jsonEncode(productsModel.toJson()));
    await prefs.setStringList("questions", questions);
  }

  final String _categoryKey = "category_title";
  final String _subtitleKey = "subtitle";
  final String _price = "price";
  TextEditingController categoryTitleController = TextEditingController();
  TextEditingController categorySubtitleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  RxList<String> savedCategories = <String>[].obs;
  RxList<String> savedSubtitle = <String>[].obs;
  RxList<String> savedPrice = <String>[].obs;

  void savedProductCategoryToSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();
    savedCategories.add(categoryTitleController.text);
    savedSubtitle.add(categorySubtitleController.text);
    savedPrice.add(priceController.text);
    await prefs.setStringList(_categoryKey, savedCategories);
    await prefs.setStringList(_subtitleKey, savedSubtitle);
    await prefs.setStringList(_price, savedPrice);

    categorySubtitleController.clear();
    categoryTitleController.clear();
    priceController.clear();
    Get.snackbar("Saved", "Category created successfully");
  }

  void loadProductCategoryFromSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();
    final catagories = prefs.getStringList(_categoryKey) ?? [];
    final subtitles = prefs.getStringList(_subtitleKey) ?? [];
    final prices = prefs.getStringList(_subtitleKey) ?? [];

    savedCategories.assignAll(catagories);
    savedSubtitle.assignAll(subtitles);
    savedSubtitle.assignAll(prices);
    update();
  }

  List<ProductsModel> getQuestionsByCategory(String category) {
    return _questions.where((question) => question.pTitle == category).toList();
  }

  @override
  void onInit() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward().whenComplete(() {});
    loadProductCategoryFromSharedPrefrences();

    update();

    super.onInit();
  }

  void deleteCategory(int index) {
    if (index >= 0 && index < savedCategories.length) {
      savedCategories.removeAt(index);
      savedSubtitle.removeAt(index);
      savedPrice.removeAt(index);
      update();
    }
  }
}
