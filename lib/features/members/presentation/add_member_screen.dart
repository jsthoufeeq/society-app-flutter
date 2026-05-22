import 'package:flutter/material.dart';
class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add Member')),
    body: const Center(child: Text('Add Member Form')),
  );
}
