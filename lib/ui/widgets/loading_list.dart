
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  final int itemsCount;

  LoadingList({Key key, @required this.itemsCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 12,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 12,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: itemsCount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
