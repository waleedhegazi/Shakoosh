import 'package:flutter/material.dart';
import 'package:test_app/Assets.dart';

class HomeOptionCard extends StatelessWidget {
  final HomeOptionCardAssets optionAsset;
  final int index;
  final void Function(int choice) onTap;
  const HomeOptionCard(
      {required this.optionAsset,
      required this.index,
      required this.onTap,
      super.key});
  @override
  Widget build(context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
              height: screenWidth * 0.2,
              width: screenWidth * 0.2,
              child: Icon(optionAsset.getIconData(), size: screenWidth * 0.15)),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: screenWidth * 0.58,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(optionAsset.getTitle(),
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(optionAsset.getDescribtion())
                ]),
          ),
          IconButton(
              onPressed: () {
                onTap(index);
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded))
        ]),
      ),
    );
  }
}

// 
