import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/constant.dart';

part 'form_body.dart';

class CustomerFormPage extends StatelessWidget {
  const CustomerFormPage({
    Key? key,
    required this.header,
  }) : super(key: key);
  final String header;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(
        leading: CommandBar(
          overflowBehavior: CommandBarOverflowBehavior.noWrap,
          primaryItems: [
            CommandBarBuilderItem(
              builder: (context, mode, w) => w,
              wrappedItem: CommandBarButton(
                icon: const Icon(
                  FluentIcons.back,
                ),
                onPressed: () {
                  context.router.pop();
                },
              ),
            ),
          ],
        ),
        title: Text(header),
      ),
      content: const CustomerFormBody(),
    );
  }
}
