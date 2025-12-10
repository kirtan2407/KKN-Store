import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'pin_controller.dart';

class PinView extends GetView<PinController> {
  final int noOfDigits;
  const PinView(this.noOfDigits, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6750A4),
      body: Column(
        children: [
          const SizedBox(height: 100),
          // ===== Card-style Container =====
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Color(0xFFF7F3FA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // ===== Logo =====
                  Center(
                    child: Image.asset(
                      'assets/logos/VIDYANAGAR APC 2.png', // replace with your logo path
                      height: 100,
                      width: 121,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // ===== Title =====
                  Text(
                    'Enter your PIN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF65558F),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ===== Name =====
                  Text(
                    'Kirtan Kankotiya',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ===== ID =====
                  Text(
                    '906',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ===== PIN Circles =====
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(noOfDigits, (index) {
                        final bool filled = index < controller.pin.value.length;
                        return Container(
                          margin: const EdgeInsets.all(8),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: filled ? Colors.black : Colors.transparent,
                            border: Border.all(width: 1.5),
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    );
                  }),

                  const SizedBox(height: 10),

                  Text(
                    'Forget Pin?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ===== Keypad =====
                  Expanded(
                    child: Obx(
                      () =>
                          controller.isLoading.value
                              ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.deepPurple,
                                ),
                              )
                              : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 12,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 70,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 0,
                                    ),
                                itemBuilder: (context, index) {
                                  if (index < 9) {
                                    return numberButton(
                                      '${index + 1}',
                                      controller,
                                    );
                                  } else if (index == 9) {
                                    return backspaceButton(controller);
                                  } else if (index == 10) {
                                    return numberButton('0', controller);
                                  } else {
                                    return const SizedBox.shrink(); // ✅ remove tick button
                                  }
                                },
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget numberButton(String number, PinController controller) {
    return GestureDetector(
      onTap: () => controller.addPin(number),
      child: Container(
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          // border: Border.all(color: Colors.deepPurple, width: 2),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget backspaceButton(PinController controller) {
    return GestureDetector(
      onTap: controller.deleteDigit,
      child: const Center(child: Icon(Iconsax.tag_cross, size: 32)),
    );
  }
}

Widget tickButton(PinController controller) {
  return GestureDetector(
    child: const Icon(Iconsax.tick_square, size: 32),
    onTap: () {
      controller.verifyPin(); // or whatever your action is
    },
  );
}
