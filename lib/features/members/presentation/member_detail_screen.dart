import 'package:flutter/material.dart';
class MemberDetailScreen extends StatelessWidget {
  final String memberId;
  const MemberDetailScreen({super.key, required this.memberId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Member Detail')),
    body: Center(child: Text('Member ID: $memberId')),
  );
}
