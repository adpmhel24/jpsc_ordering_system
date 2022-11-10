import 'package:fluent_ui/fluent_ui.dart';

class UnknownRoutePage extends StatefulWidget {
  const UnknownRoutePage({super.key});

  @override
  State<UnknownRoutePage> createState() => _UnknownRoutePageState();
}

class _UnknownRoutePageState extends State<UnknownRoutePage> {
  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      content: Center(
        child: Text("Invalid"),
      ),
    );
  }
}
