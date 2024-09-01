import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_provider.dart';

class ConsumerStfulWidget extends ConsumerStatefulWidget {
  const ConsumerStfulWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConsumerStfulWidgetState();
}

class _ConsumerStfulWidgetState extends ConsumerState<ConsumerStfulWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final favorites = ref.watch(favoritesProvider);
  }

  void aFunction() {
    final favorites = ref.watch(favoritesProvider);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider);
    return Container();
  }
}
