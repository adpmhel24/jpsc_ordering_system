import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repos.dart';
import 'custom_dropdown_search.dart';
import '../../utils/constant.dart';

class WarehouseSelectionModal extends StatefulWidget {
  const WarehouseSelectionModal({
    Key? key,
    required this.selectedWhse,
    this.onChanged,
    this.selectedBranch,
  }) : super(key: key);

  final String selectedWhse;
  final ValueChanged<WarehouseModel>? onChanged;
  final String? selectedBranch;

  @override
  State<WarehouseSelectionModal> createState() =>
      _WarehouseSelectionModalState();
}

class _WarehouseSelectionModalState extends State<WarehouseSelectionModal> {
  final String title = "Select Warehouse"; // Title

  // will hold here the value of search box
  late String _keyword = "";

  late String _selectedBranch = "";

  @override
  void initState() {
    setState(() {
      _selectedBranch = widget.selectedBranch ?? "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return m.AlertDialog(
      title: Text(title),
      contentPadding: const EdgeInsets.all(Constant.minPadding),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextFormBox(
              autofocus: true,
              header: "Search",
              onChanged: (value) {
                setState(() {
                  _keyword = value;
                });
              },
            ),
          ),
          Constant.heightSpacer,
          if (widget.selectedBranch == null) _dropDownBranchCodeField(),
          Constant.heightSpacer,
          const m.Divider(
            thickness: 2,
            color: Colors.grey,
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: 300,
              child: FutureBuilder(
                future: context.read<WarehouseRepo>().offlineSearch(
                      keyword: _keyword,
                      branchCode: _selectedBranch,
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
                        selected:
                            widget.selectedWhse == snapshot.data[index].code,
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

  Flexible _dropDownBranchCodeField() {
    return Flexible(
      child: InfoLabel(
        label: "Branch",
        child: m.Material(
          child: MyCustomDropdownSearch<BranchModel>(
            autoValidateMode: AutovalidateMode.always,
            enable: (widget.selectedBranch == null) ? true : false,
            itemAsString: (branch) => branch!.code,
            onFind: (String? filter) =>
                context.read<BranchRepo>().offlineSearch(filter!),
            compareFn: (branch, selectedBranch) =>
                branch!.code == selectedBranch!.code,
            onChanged: (BranchModel? data) {
              setState(() {
                _selectedBranch = data?.code ?? "";
              });
            },
          ),
        ),
      ),
    );
  }
}
