import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String? title;
  final bool? isDone;
  final Function(bool?)? toggleStatus;
  final void Function(DismissDirection?)? deleteItem;

  ItemCard({this.isDone, this.title, this.toggleStatus, this.deleteItem});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: deleteItem,
      child: Card(
        color: isDone! ? Colors.green.shade50 : Colors.white,
        shadowColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: isDone! ? 1 : 5,
        child: ListTile(
          title: Text(
            "${title}",
            style: TextStyle(
                color: Colors.black,
                decoration: isDone! ? TextDecoration.lineThrough : null),
          ),
          trailing: Checkbox(
              onChanged: toggleStatus,
              value: isDone,
              activeColor: Colors.green),
        ),
      ),
    );
  }
}
