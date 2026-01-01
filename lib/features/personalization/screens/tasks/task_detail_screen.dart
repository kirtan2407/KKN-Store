import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.taskNumber});

  final int taskNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KknAppbar(showArrowBack: true, title: Text('Task $taskNumber')),
      body: Center(child: Text('Details for Task $taskNumber')),
    );
  }
}
