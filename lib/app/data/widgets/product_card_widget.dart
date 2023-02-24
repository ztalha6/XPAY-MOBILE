import 'package:flutter/material.dart';
import 'package:serveeasy_app/app/data/models/menu/menu_data_response_model.dart';
import 'package:serveeasy_app/app/data/widgets/cached_image_widget.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});
  final Product product;
  final Function()? onTap;
  TextTheme _textTheme(context) => Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      child: CachedImageWidget(
                        url: product.productSingleImage.mediaUrl!,
                      ),
                    ),
                  ),
                  const SizedBox(width: 11),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          product.name!,
                          overflow: TextOverflow.ellipsis,
                          style: _textTheme(context)
                              .headlineMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      Visibility(
                        visible: product.description!.isNotEmpty,
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 200,
                              child: Text(
                                product.description!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: _textTheme(context).headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "\$ ${product.price!}",
                            overflow: TextOverflow.ellipsis,
                            style: _textTheme(context)
                                .headlineMedium!
                                .copyWith(color: Colors.black),
                          ),
                          // ElevatedButton(
                          //     onPressed: () {},
                          //     style: ElevatedButton.styleFrom(
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         backgroundColor: Colors.lightGreen,
                          //         fixedSize: const Size(40, 40)),
                          //     child: const Icon(Icons.add))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
