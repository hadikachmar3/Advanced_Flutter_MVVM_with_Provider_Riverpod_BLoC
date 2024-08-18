import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
    required this.errorText,
    required this.retryFunction,
  });
  final String errorText;
  final Function retryFunction;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            MyAppIcons.error,
            size: 50,
            color: Colors.red,
          ),
          const SizedBox(height: 20),
          Text('Error: $errorText',
              style: const TextStyle(color: Colors.red, fontSize: 16)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              retryFunction();
            },
            child: const Text(
              'Retry',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
