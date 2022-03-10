import 'package:flutter/material.dart';
import 'package:getitdone/models/items_data.dart';
import 'package:provider/provider.dart';

class ItemAdder extends StatelessWidget {
  TextEditingController myController = TextEditingController();
  ItemAdder({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 3,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  controller: myController,
                  onSubmitted: (s) {
                    Provider.of<ItemsData>(context, listen: false)
                        .addItem(myController.text);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Add Item",
                    hintText: "...",
                  ),
                  autofocus: true,
                ),
              ),
              TextButton(
                child: Text(
                  "Add",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                onPressed: () {
                  print(myController.text);
                  Provider.of<ItemsData>(context, listen: false)
                      .addItem(myController.text);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor)),
              )
            ]),
      ),
    );
  }
}
