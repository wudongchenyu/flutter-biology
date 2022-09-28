import 'package:flutter/material.dart';
import 'package:life/classes/model/species.dart';

import '../../classes/consumer_router_delegate.dart';
import '../../icons/all_icons.dart';

class LeftMenuItemWidget extends StatefulWidget {
  final Species species;

  final bool open;

  final List<Species> speciesList;

  const LeftMenuItemWidget(
      {Key? key,
      required this.species,
      required this.open,
      required this.speciesList})
      : super(key: key);

  @override
  State<LeftMenuItemWidget> createState() => _LeftMenuItemWidgetState();
}

class _LeftMenuItemWidgetState extends State<LeftMenuItemWidget> {
  late bool selected = true;
  late int showIcon = widget.species.children?.length ?? 0;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TextButton(
        onPressed: () async {
          Navigator.pop(context);
          Delegate().push(
            name: '/biology/page',
            arguments: {
              'species' : widget.species,
            }
          );
        },
        style: const ButtonStyle(
          alignment: Alignment.centerLeft,
          ),
        child: Text(
          widget.species.speciesName,
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      // leading: const Icon(
      //   AllIcons.ice_cube,
      //   color: Colors.white,
      // ),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      trailing: showIcon == 0
          ? const SizedBox()
          : Icon(
              selected ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
      onExpansionChanged: (e) {
        setState(() {
          selected = !e;
        });
      },
      children: buildExpansionTile(widget.species, widget.speciesList) ?? [],
    );
  }

  List<Species> acquireChildren(Species e, List<Species> sps) {
    return sps.where((element) => e.code == element.parent).toList();
  }

  List<LeftMenuItemWidget>? buildExpansionTile(
      Species species, List<Species> sps) {
    return species.children
        ?.map((e) => LeftMenuItemWidget(
            species: e, open: e.level != 0, speciesList: sps))
        .toList();
  }
}
