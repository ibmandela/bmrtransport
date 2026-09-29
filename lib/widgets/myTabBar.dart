import 'package:flutter/material.dart';

class Mytabbar extends StatefulWidget {
  final List<String> categoryList;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final ValueNotifier<double> width;
  // final Color backgroundColor;
  const Mytabbar({
    super.key,
    required this.categoryList,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.width,
    // required this.backgroundColor,
  });

  @override
  State<Mytabbar> createState() => _MytabbarState();
}

class _MytabbarState extends State<Mytabbar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.categoryList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    if (!_tabController.indexIsChanging) {
      _tabController.index = widget.selectedIndex;
    }
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        widget.onDestinationSelected(_tabController.index);
      }
    });
    return TabBar(
      controller: _tabController,
      tabs: widget.categoryList.map((d) {
        return Tab(text: d);
      }).toList(),
    );
  }
}
