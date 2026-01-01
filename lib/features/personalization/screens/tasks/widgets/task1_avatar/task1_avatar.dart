import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kkn_store/common/widgets/appbar/appbar.dart';
import 'package:kkn_store/utils/constants/colors.dart';

class TasksAvatar extends StatelessWidget {
  const TasksAvatar({
    super.key,
    required this.imageUrl,
    required this.onUpload,
  });

  final String? imageUrl;
  final void Function()? onUpload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KknAppbar(
        title: Text(
          'Avatar Task',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.apply(color: TColors.white),
        ),
        showArrowBack: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child:
                imageUrl != null
                    ? Image.network(imageUrl!, fit: BoxFit.cover)
                    : Container(
                      child: const Center(child: Text('no image fount')),
                    ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              // Pick an image.
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if(image != null && onUpload != null) {
                return;
              }
              // final ImageBytes = await image?.readAsBytes();
              // supabase.storage.from('');
            },
            child: Text('Upload Avatar'),
          ),
        ],
      ),
    );
  }
}
