import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repos.dart';
import '../../pages/widgets/custom_dropdown_search.dart';
import '../../utils/constant.dart';

class ItemSelectionModal extends StatefulWidget {
  const ItemSelectionModal(
      {Key? key,
      required this.itemRepo,
      required this.selectedItem,
      this.onChanged})
      : super(key: key);

  final ProductRepo itemRepo;
  final String selectedItem;
  final ValueChanged<ProductModel>? onChanged;

  @override
  State<ItemSelectionModal> createState() => _ItemSelectionModalState();
}

class _ItemSelectionModalState extends State<ItemSelectionModal> {
  late String _searchKeyword = "";
  late String _selectedItemGroup = "";

  @override
  Widget build(BuildContext context) {
    return m.AlertDialog(
      title: const Text("Select Item"),
      contentPadding: const EdgeInsets.all(Constant.minPadding),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextFormBox(
              header: "Search",
              onChanged: (value) {
                setState(() {
                  _searchKeyword = value;
                });
              },
              autofocus: true,
            ),
          ),
          Constant.heightSpacer,
          _dropDownItemGroupField(),
          Constant.heightSpacer,
          const m.Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: 300,
              // height: double.maxFinite,
              child: FutureBuilder(
                future: widget.itemRepo.offlineSearch(
                  keyword: _searchKeyword,
                  itemGroupCode: _selectedItemGroup,
                ),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.data == null) {
                    return Container();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: ProgressRing(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return m.ListTile(
                        title: Text(snapshot.data[index].code),
                        subtitle: Text("${snapshot.data[index].description}"),
                        selected:
                            widget.selectedItem == snapshot.data[index].code,
                        onTap: () {
                          if (widget.onChanged != null) {
                            widget.onChanged!(snapshot.data[index]);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Flexible _dropDownItemGroupField() {
    return Flexible(
      child: InfoLabel(
        label: "Item Group",
        child: m.Material(
          child: MyCustomDropdownSearch<ItemGroupModel>(
            autoValidateMode: AutovalidateMode.always,
            // selectedItem: _selectedItemGroup,
            itemAsString: (itemGroup) => itemGroup!.code,
            onFind: (String? filter) =>
                context.read<ItemGroupRepo>().offlineSearch(filter!),
            compareFn: (item, selectedItem) => item!.code == selectedItem!.code,
            onChanged: (ItemGroupModel? data) {
              setState(() {
                _selectedItemGroup = data?.code ?? "";
              });
            },
          ),
        ),
      ),
    );
  }
}
