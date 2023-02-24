import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({
    Key? key,
    required this.secondaryColor,
  }) : super(key: key);
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16,
        bottom: 4.0,
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: const Color(0xFF58B09C),
        strokeWidth: 1.5,
        dashPattern: const [8, 8],
        radius: const Radius.circular(12),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            color: const Color(0xFF58B09C).withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          "Halloween Voucher",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "VRE332113",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: const Color(0xFF58B09C),
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ 123",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Valid Upto: ",
                            style:
                                Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontSize: 12,
                                    ),
                          ),
                          Text(
                            "16th Nov 2022",
                            style:
                                Theme.of(context).textTheme.displayLarge!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Min: ",
                            style:
                                Theme.of(context).textTheme.headlineMedium!.copyWith(
                                      fontSize: 12,
                                    ),
                          ),
                          Text(
                            "\$ 0.09",
                            style:
                                Theme.of(context).textTheme.displayLarge!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
