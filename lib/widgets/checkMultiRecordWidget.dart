import 'package:flutter/material.dart';

class CheckMultiRecordWidget<T> extends StatelessWidget {
  final AsyncSnapshot<List<T>> snapshot;
  final Widget? loader;
  final Widget? error;
  final Widget? nothingFound;

  const CheckMultiRecordWidget({
    required this.snapshot,
    this.loader,
    this.error,
    this.nothingFound,
  });

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader!;
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasData && snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound!;
      return const Center(child: Text('Sem registros encontrados!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error!;
      return const Center(child: Text('Algo de errado ocorreu'));
    }

    return Container();
  }
}
