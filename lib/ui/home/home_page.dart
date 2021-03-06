import 'package:cobble/ui/common/icons/fonts/rebble_icons.dart';
import 'package:cobble/ui/home/tabs/settings_tab.dart';
import 'package:cobble/ui/home/tabs/store_tab.dart';
import 'package:cobble/ui/home/tabs/test_tab.dart';
import 'package:cobble/ui/home/tabs/watches_tab.dart';
import 'package:cobble/ui/router/cobble_screen.dart';
import 'package:cobble/ui/test/watch_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../common/icons/fonts/rebble_icons.dart';

class _TabConfig {
  final Widget child;
  final String label;
  final IconData icon;

  _TabConfig(this.child, this.label, this.icon);
}

class HomePage extends HookWidget implements CobbleScreen {
  final _config = [
    _TabConfig(TestTab(), "Testing", RebbleIcons.send_to_watch_checked),
    _TabConfig(Placeholder(), "Health", RebbleIcons.health_journal),
    _TabConfig(WatchCarousel(), "Locker", RebbleIcons.locker),
    _TabConfig(StoreTab(), "Store", RebbleIcons.rebble_store),
    _TabConfig(MyWatchesTab(), "Watches", RebbleIcons.devices),
    _TabConfig(SettingsTab(), "Settings", RebbleIcons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final index = useState(0);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (i) => index.value = i,
        currentIndex: index.value,
        items: _config
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.label,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            )
            .toList(),
      ),
      body: IndexedStack(
        children: _config
            .map(
              (tab) => Navigator(
                onGenerateInitialRoutes: (navigator, initialRoute) => [
                  CupertinoPageRoute(builder: (_) => tab.child),
                ],
              ),
            )
            .toList(),
        index: index.value,
      ),
    );
  }
}
