import 'package:flutter/material.dart';
import 'package:serveeasy_app/app/data/enum/order_statuses.dart';
import 'package:serveeasy_app/core/constants/configuration.dart';
import 'package:timelines/timelines.dart';

class DeliveryProcessWidget extends StatelessWidget {
  DeliveryProcessWidget({Key? key, required this.status}) : super(key: key);

  final OrderStatus status;
  final List<String> statuses = [
    'Order Placed',
    'Confirming order',
    'Order dispatched',
    'Order Delivery'
  ];
  final DotIndicator activeIndicator = DotIndicator(
    color: Configuration().secondaryColor.withOpacity(0.9),
    child: const Icon(
      Icons.check,
      color: Colors.white,
      size: 18.0,
    ),
  );
  final Configuration configuration = Configuration();

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headlineMedium!,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: const Color(0xff989898),
            indicatorTheme: const IndicatorThemeData(
              position: 0,
              size: 25.0,
            ),
            connectorTheme: const ConnectorThemeData(
              thickness: 2.0,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: 4,
            contentsBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        statuses[index],
                        style: DefaultTextStyle.of(context).style.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "05:30 PM",
                        style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 13.0,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (status == OrderStatus.ordered && index <= 0 ||
                  status == OrderStatus.kitchen && index <= 1 ||
                  status == OrderStatus.dispatch && index <= 2 ||
                  status == OrderStatus.delivered && index <= 3) {
                return activeIndicator;
              } else {
                return const OutlinedDotIndicator(
                  borderWidth: 1.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              thickness: 1.2,
              color: status == OrderStatus.ordered && index <= 0 ||
                      status == OrderStatus.kitchen && index <= 1 ||
                      status == OrderStatus.dispatch && index <= 2 ||
                      status == OrderStatus.delivered && index <= 3
                  ? configuration.secondaryColor
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
