import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'package:kkn_store/features/personalization/screens/tasks/task_detail_screen.dart';
import 'package:kkn_store/features/personalization/screens/tasks/widgets/task1_avatar/task1_avatar.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KknAppbar(
        title: Text(
          'Tasks List',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.apply(color: TColors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          final taskNumber = index + 1;
          if (taskNumber == 1) {
            return ListTile(
              title: const Text('Task 1: Avatar'),
              trailing: const Icon(Icons.arrow_forward_ios),
              // onTap: () => Get.to(() => const TasksAvatar()),
            );
          } else {
            return ListTile(
              title: Text('Task $taskNumber'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap:
                  () => Get.to(() => TaskDetailScreen(taskNumber: taskNumber)),
            );
          }
        },
      ),
    );
  }
}
