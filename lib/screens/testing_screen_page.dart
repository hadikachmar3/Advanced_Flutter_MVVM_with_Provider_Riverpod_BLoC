import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';

class TestingScreenPage extends StatelessWidget {
  const TestingScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestingScreenPage'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            const genre1 = MoviesGenre(id: 1, name: 'Action');
            const genre2 = MoviesGenre(id: 1, name: 'Action');
            log("Is genre1 is equal to genre1 ${genre1 == genre1}");
            log("Is genre2 is equal to genre2 ${genre2 == genre2}");
            log("Is genre1 is equal to genre2 ${genre1 == genre2}");
          },
          child: const Text("press me"),
        ),
      ),
    );
  }
}
