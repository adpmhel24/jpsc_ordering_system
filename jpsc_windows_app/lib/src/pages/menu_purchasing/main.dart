import 'package:fluent_ui/fluent_ui.dart';

class PurchasingMenuPage extends StatelessWidget {
  const PurchasingMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text("Purchasing Menu"),
      ),
      children: const [
        Text("Purchasing Menu"),
      ],
    );
  }
}
