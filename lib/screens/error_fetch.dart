import 'package:flutter/material.dart';

class EmptyStateScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  EmptyStateScreen({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.orange,
            size: 60,
          ),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
