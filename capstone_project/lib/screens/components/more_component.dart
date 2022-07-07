// import package
import 'package:flutter/material.dart';

// import theme
import 'package:capstone_project/themes/nomizo_theme.dart';

// import component
import 'package:capstone_project/screens/components/card_widget.dart';

class MoreComponent extends StatefulWidget {
  final List<String> myLabels;
  final List<void Function()> myFunctions;

  const MoreComponent({
    Key? key,
    required this.myLabels,
    required this.myFunctions,
  }) : super(key: key);

  @override
  State<MoreComponent> createState() => _MoreComponentState();
}

class _MoreComponentState extends State<MoreComponent> {
  late final List<String> labels;
  late final List<void Function()> functions;

  @override
  void initState() {
    labels = widget.myLabels;
    functions = widget.myFunctions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 2,
            color: NomizoTheme.nomizoDark.shade600,
          ),
          // menu
          ListView.separated(
            separatorBuilder: (context, index) => buildDivider(),
            itemCount: labels.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return moreMenu(label: labels[index], function: functions[index]);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget moreMenu({required String label, required void Function() function}) {
    return InkWell(
      onTap: function,
      child: Column(
        children: [
          Container(
            height: 42,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
