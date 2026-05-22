import 'package:flutter/material.dart';
class MemberListScreen extends StatelessWidget {
  const MemberListScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Members')),
    body: const Center(child: Text('Member List')),
  );
}
