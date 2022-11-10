import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../data/models/models.dart';
import '../../router/router.gr.dart';

class MasterDataMenuPage extends StatefulWidget {
  const MasterDataMenuPage({Key? key}) : super(key: key);

  static final _items = [
    MenuItems<SystemUsersWrapper>(
      name: "System Users",
      icon: const ImageIcon(
        AssetImage('assets/icons/user_account.png'),
        size: 40,
      ),
      route: const SystemUsersWrapper(),
    ),
    MenuItems(
      name: "Customers",
      icon: const ImageIcon(
        AssetImage('assets/icons/account.png'),
        size: 40,
      ),
      route: const CustomerWrapper(),
    ),
    MenuItems(
      name: "Branches",
      icon: const ImageIcon(
        AssetImage('assets/icons/branch.png'),
        size: 40,
      ),
      route: const BranchesWrapper(),
    ),
    MenuItems(
      name: "Pricelists",
      icon: const ImageIcon(
        AssetImage('assets/icons/tags.png'),
        size: 40,
      ),
      route: const PricelistWrapper(),
    ),
    MenuItems(
      name: "Products",
      icon: const ImageIcon(
        AssetImage('assets/icons/product.png'),
        size: 40,
      ),
      route: const ProductsWrapper(),
    ),
    MenuItems(
      name: "Unit Of Measures",
      icon: const ImageIcon(
        AssetImage('assets/icons/uom.png'),
        size: 40,
      ),
      route: const UomsWrapper(),
    ),
    MenuItems(
      name: "Payment Terms",
      icon: const ImageIcon(
        AssetImage('assets/icons/payment_terms.png'),
        size: 40,
      ),
      route: const PaymentTermWrapper(),
    ),
    MenuItems(
      name: "Item Groups",
      icon: const ImageIcon(
        AssetImage('assets/icons/item_group.png'),
        size: 40,
      ),
      route: const ItemGroupWrapper(),
    ),
  ];

  @override
  State<MasterDataMenuPage> createState() => _MasterDataMenuPageState();
  // static String snakeCasetoSentenceCase(String original) {
  //   return '${original[0].toUpperCase()}${original.substring(1)}'
  //       .replaceAll(RegExp(r'(_|-)+'), ' ');
  // }
}

class _MasterDataMenuPageState extends State<MasterDataMenuPage> {
  String filterText = '';
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(
        title: const Text("Master Data Menu"),
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
        children: MasterDataMenuPage._items
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


//   }
