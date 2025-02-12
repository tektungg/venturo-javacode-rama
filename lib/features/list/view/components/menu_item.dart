import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:venturo_core/features/list/controllers/list_controller.dart';
import 'package:venturo_core/features/list/view/components/menu_card.dart';

Widget buildMenuItem(Map<String, dynamic> item) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.5.h),
    child: Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              ListController.to.deleteItem(item);
            },
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(10.r),
            ),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10.r),
        elevation: 2,
        child: MenuCard(
          key: ValueKey(item['id_menu']),
          menu: item,
          isSelected: ListController.to.selectedItems.contains(item),
          onTap: () {
            if (ListController.to.selectedItems.contains(item)) {
              ListController.to.selectedItems.remove(item);
            } else {
              ListController.to.selectedItems.add(item);
            }
          },
        ),
      ),
    ),
  );
}