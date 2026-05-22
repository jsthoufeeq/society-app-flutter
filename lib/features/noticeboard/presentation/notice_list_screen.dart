import 'package:flutter/material.dart';
class NoticeListScreen extends StatelessWidget {
  const NoticeListScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Noticeboard')),
    body: const Center(child: Text('Notices')),
  );
}
