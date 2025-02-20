import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityCounter extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  const QuantityCounter({
    super.key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (quantity > 0) Visibility(
          visible: onDecrement != null,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              onTap: onDecrement,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.r,
                  ),
                ),

                child: Icon(
                  Icons.remove,
                  size: 20.r,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),

        if (quantity > 0) Container(
          constraints: BoxConstraints(minWidth: 30.r),
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: Text(
            quantity.toString(),
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        Visibility(
          visible: onIncrement != null,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: Material(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              onTap: onIncrement,
              child: Ink(
                padding: EdgeInsets.all(2.r),
                color: Theme.of(context).primaryColor,
                child: Icon(Icons.add, size: 20.r, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}