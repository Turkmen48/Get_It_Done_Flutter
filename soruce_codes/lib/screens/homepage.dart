import 'package:flutter/material.dart';
import 'package:getitdone/models/items_data.dart';
import 'package:getitdone/screens/settingspage.dart';
import 'package:getitdone/widgets/item_adder.dart';
import 'package:getitdone/widgets/item_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${Provider.of<ItemsData>(context).items.length} Items",
                style: Theme.of(context).textTheme.headline3,
              ),
            )),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Consumer<ItemsData>(
                    builder: (context, itemData, child) => Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return ItemCard(
                            deleteItem: (_) {
                              itemData.deleteItem(index);
                            },
                            toggleStatus: (bool) {
                              itemData.toggleStatus(index);
                            },
                            title: itemData.items[index].title,
                            isDone: itemData.items[index].isDone,
                          );
                        },
                        itemCount: itemData.items.length,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: buildFAB(context),
    );
  }

  FloatingActionButton buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: false,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(25.0))),
            context: context,
            builder: (context) => ItemAdder());
      },
      child: Icon(Icons.add),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(title: Text("Get It Done"), actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          iconSize: 25,
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ),
      )
    ]);
  }
}
