import 'package:fluent_ui/fluent_ui.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text("Dashboard"),
      ),
      children: const [
        Text("Dashboard"),
      ],
    );
  }
}
