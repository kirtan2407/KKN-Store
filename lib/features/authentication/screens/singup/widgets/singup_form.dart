// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kkn_store/features/authentication/screens/singup/widgets/term&condition_checkbox.dart';
// import 'package:kkn_store/utils/constants/sizes.dart';
// import 'package:kkn_store/utils/constants/text_string.dart';
// import 'package:kkn_store/utils/helpers/helper_function.dart';

// import '../varify_email.dart';

// class SingupForm extends StatelessWidget {
//   const SingupForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Form(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: TTexts.firstName,
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: TSizes.spaceBtwInputFields),
//               Expanded(
//                 child: TextFormField(
//                   expands: false,
//                   decoration: const InputDecoration(
//                     labelText: TTexts.lastName, // ✅ FIXED label text
//                     prefixIcon: Icon(Iconsax.user),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),

//           ///username
//           TextFormField(
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: TTexts.username,
//               prefixIcon: Icon(Iconsax.user_edit),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),

//           ///Email
//           TextFormField(
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: TTexts.email,
//               prefixIcon: Icon(Iconsax.direct),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),

//           ///Phone Number
//           TextFormField(
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: TTexts.phoneNo,
//               prefixIcon: Icon(Iconsax.call),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),

//           ///Password
//           TextFormField(
//             expands: false,
//             decoration: const InputDecoration(
//               labelText: TTexts.password,
//               prefixIcon: Icon(Iconsax.password_check),
//               suffixIcon: Icon(Iconsax.eye_slash1),
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwItems),

//           ///transaction Checkbox
//           ///Term & Condition
//           TermAndConditionCheckbox(),
//           SizedBox(height: TSizes.spaceBtwsections),

//           ///singup Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () => Get.to(() => VarifyEmailScreen()),
//               child: const Text(TTexts.createAccount),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kkn_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:kkn_store/features/authentication/screens/singup/widgets/term&condition_checkbox.dart';
import 'package:kkn_store/utils/constants/sizes.dart';
import 'package:kkn_store/utils/constants/text_string.dart';
import 'package:kkn_store/utils/helpers/helper_function.dart';
import 'package:kkn_store/utils/validators/validation.dart';

class SingupForm extends StatelessWidget {
  const SingupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // FIRST NAME — LAST NAME
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => TValidator.validateEmptyText('First Name', value),
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => TValidator.validateEmptyText('Last Name', value),
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // USERNAME
          TextFormField(
            controller: controller.username,
            validator: (value) => TValidator.validateUsername(value),
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // EMAIL
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // PHONE
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // PASSWORD
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // -------------------------------
          //      DATE OF BIRTH FIELD
          // -------------------------------
          Obx(
            () => InkWell(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  controller.dob.value = pickedDate;
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  prefixIcon: Icon(Iconsax.calendar),
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  controller.dob.value == null
                      ? "Select Date"
                      : "${controller.dob.value!.day}/${controller.dob.value!.month}/${controller.dob.value!.year}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // -------------------------------
          //         GENDER RADIO
          // -------------------------------
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Gender",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: "Male",
                      groupValue: controller.gender.value,
                      onChanged: (value) => controller.gender.value = value!,
                    ),
                    const Text("Male"),

                    Radio<String>(
                      value: "Female",
                      groupValue: controller.gender.value,
                      onChanged: (value) => controller.gender.value = value!,
                    ),
                    const Text("Female"),

                    Radio<String>(
                      value: "Other",
                      groupValue: controller.gender.value,
                      onChanged: (value) => controller.gender.value = value!,
                    ),
                    const Text("Other"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // TERMS & CONDITIONS
          const TermAndConditionCheckbox(),
          const SizedBox(height: TSizes.spaceBtwsections),

          // SIGNUP BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}

