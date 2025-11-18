import 'package:flutter/material.dart';

class ContentValidator extends StatelessWidget {
  final Future future;
  final dynamic data;
  final Widget Function() builder;
  final String emptyMessage;

  const ContentValidator({
    super.key,
    required this.future,
    required this.data,
    required this.builder,
    this.emptyMessage = "No hay resultados para mostrar",
  });

  bool _isEmpty(dynamic value) {
    if (value == null) return true;
    if (value is List && value.isEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        // LOADING
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // EMPTY
        if (_isEmpty(data)) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              emptyMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }

        // SUCCESS
        return builder();
      },
    );
  }
}
