import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../data/models/models.dart';
import '../../router/router.gr.dart';

class InventoryMenuPage extends StatefulWidget {
  const InventoryMenuPage({Key? key}) : super(key: key);

  static final _items = [
    MenuItems(
      name: "Adjustment In",
      icon: const ImageIcon(
        AssetImage('assets/icons/in.png'),
        size: 40,
      ),
      route: const InvAdjInWrapper(),
    ),
    MenuItems(
      name: "Adjustment Out",
      icon: const ImageIcon(
        AssetImage('assets/icons/out.png'),
        size: 40,
      ),
      route: const InvAdjOutWrapper(),
    ),
    // MenuItems(
    //   name: "Inventory Transfer Request",
    //   icon: const ImageIcon(
    //     AssetImage('assets/icons/warehouse.png'),
    //     size: 40,
    //   ),
    //   route: const WarehousesWrapper(),
    // ),
    // MenuItems(
    //   name: "Inventory Transfer",
    //   icon: const ImageIcon(
    //     AssetImage('assets/icons/product.png'),
    //     size: 40,
    //   ),
    //   route: const ProductsWrapper(),
    // ),
    // MenuItems(
    //   name: "Inventory Receive",
    //   icon: const ImageIcon(
    //     AssetImage('assets/icons/uom.png'),
    //     size: 40,
    //   ),
    //   route: const UomsWrapper(),
    // ),
  ];

  @override
  State<InventoryMenuPage> createState() => _InventoryMenuPageState();

  static String snakeCasetoSentenceCase(String original) {
    return '${original[0].toUpperCase()}${original.substring(1)}'
        .replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}

class _InventoryMenuPageState extends State<InventoryMenuPage> {
  String filterText = '';
  final String title = "Inventory Menu";
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(
        title: Text(title),
        commandBar: SizedBox(
          width: 240.0,
          child: Tooltip(
            message: 'Filter by name',
            child: TextBox(
              suffix: const Icon(FluentIcons.search),
              placeholder: 'Type to filter menu by name (e.g "system users")',
              onChanged: (value) => setState(() {
                filterText = value;
              }),
            ),
          ),
        ),
      ),
      content: GridView.extent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.only(top: kPageDefaultVerticalPadding),
        children: InventoryMenuPage._items
            .where((item) =>
                filterText.isEmpty ||
                item.name.toLowerCase().contains(filterText.toLowerCase()))
            .map((e) {
          return HoverButton(
            onPressed: () {
              if (e.route != null) {
                context.router.push(e.route!);
              }
            },
            cursor: SystemMouseCursors.click,
            builder: (context, states) {
              return FocusBorder(
                focused: states.isFocused,
                child: Tooltip(
                  useMousePosition: false,
                  message: e.name,
                  child: RepaintBoundary(
                    child: AnimatedContainer(
                      duration: FluentTheme.of(context).fasterAnimationDuration,
                      decoration: BoxDecoration(
                        color: ButtonThemeData.uncheckedInputColor(
                          FluentTheme.of(context),
                          states,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          e.icon,
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              e.name,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
