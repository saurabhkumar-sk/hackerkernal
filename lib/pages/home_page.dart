import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackerkernel_assignment/controller/product_controller.dart';
import 'package:hackerkernel_assignment/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    productController.loadProductCategoryFromSharedPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton.filled(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          onPressed: null,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        actions: <Widget>[
          MyAnimSearchBar(),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hi-Fi Shop & Services",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Audio Shop on Rustaveli Ave 57.",
                style: TextStyle(
                  // fontSize: 30,
                  // fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const Text(
                "This shop offers both products and services",
                style: TextStyle(
                  // fontSize: 30,
                  // fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Products",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "  ${productController.savedCategories.length}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const TextButton(
                      onPressed: null,
                      child: Text(
                        "Show all",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ))
                ],
              ),
              GetBuilder<ProductController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.savedCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: Colors.grey,
                                        child: Image.asset(
                                          "assets/images/headset.jpeg",
                                          fit: BoxFit.fitWidth,
                                          height: 100,
                                          // width: 200,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 62),
                                        child: IconButton(
                                          onPressed: () {
                                            controller.deleteCategory(index);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    controller.savedCategories[index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    controller.savedSubtitle[index],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "₹ ${controller.savedPrice[index]}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomDialog(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

//Dialog Box
void showCustomDialog(BuildContext context) {
  final ProductController productController = Get.put(ProductController());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Add Products"),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              TextFormField(
                controller: productController.categoryTitleController,
                decoration:
                    const InputDecoration(hintText: "Enter the Product name"),
              ),
              TextFormField(
                controller: productController.categorySubtitleController,
                decoration: const InputDecoration(
                    hintText: "Enter the Product subtitle"),
              ),
              TextFormField(
                controller: productController.priceController,
                decoration:
                    const InputDecoration(hintText: "Enter the Product price"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              productController.savedProductCategoryToSharedPrefrences();
              Get.back();
            },
            child: const Text("Create"),
          ),
        ],
      );
    },
  );
}

class MyAnimSearchBar extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  MyAnimSearchBar({super.key});

  void onSuffixTap() {}

  void onSubmitted(String value) {}

  @override
  Widget build(BuildContext context) {
    return AnimSearchBar(
      width: 360,
      textController: searchController,
      onSuffixTap: onSuffixTap,
      onSubmitted: onSubmitted,
    );
  }
}
