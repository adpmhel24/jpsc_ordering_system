import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppMenu {
  static List<NavigationPaneItem> menuItems = [
    _paneItemBuilder(
      svgSrc: "assets/icons/chart.svg",
      title: "Dashboard",
    ),
    // _paneItemBuilder(
    //   svgSrc: "assets/icons/menu_tran.svg",
    //   title: "Purchasing",
    // ),
    _paneItemBuilder(
      svgSrc: "assets/icons/menu_tag.svg",
      title: "Sales",
    ),
    // _paneItemBuilder(
    //   svgSrc: "assets/icons/menu_inventory.svg",
    //   title: "Inventory",
    // ),
    _paneItemBuilder(
      svgSrc: "assets/icons/database.svg",
      title: "Master Data",
    ),
  ];
}

PaneItem _paneItemBuilder({
  required String svgSrc,
  required String title,
}) {
  return PaneItem(
    icon: SvgPicture.asset(
      svgSrc,
      color: Colors.green,
      height: 15,
    ),
    title: Text(title),
  );
}
