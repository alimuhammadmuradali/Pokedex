import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  const NoResults({Key? key, required this.description}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
              child: Text(
                description,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontSize: 16,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
