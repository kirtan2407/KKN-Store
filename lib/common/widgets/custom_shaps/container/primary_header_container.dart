// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kkn_store/common/widgets/custom_shaps/container/circular_container.dart';
import 'package:kkn_store/common/widgets/custom_shaps/curved_edgs/curved_edge_widgets.dart';
import 'package:kkn_store/utils/constants/colors.dart';
import 'dart:math' as math;

class TPrimaryHeaderConatainer extends StatefulWidget {
  const TPrimaryHeaderConatainer({super.key, required this.child});
  final Widget child;

  @override
  State<TPrimaryHeaderConatainer> createState() =>
      _TPrimaryHeaderConatainerState();
}

class _TPrimaryHeaderConatainerState extends State<TPrimaryHeaderConatainer>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _rotationController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Floating animation for circles
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Fade in animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    // Scale animation for circles
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // Start animations
    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _floatingController,
        _fadeController,
        _scaleController,
        _rotationController,
      ]),
      builder: (context, child) {
        return TCurvedEdgeWidgets(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  TColors.primaryColor,
                  TColors.primaryColor.withOpacity(0.85),
                  TColors.primaryColor.withOpacity(0.95),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated gradient overlay
                Positioned.fill(
                  child: Opacity(
                    opacity: _fadeAnimation.value * 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topRight,
                          radius: 1.5,
                          colors: [
                            Colors.white.withOpacity(0.2),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Large rotating circle - top right
                Positioned(
                  top: -150 + _floatingAnimation.value,
                  right: -250,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value * 0.3,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: TCircularContainer(
                          width: 450,
                          height: 450,
                          backgroundColor: TColors.textWhite.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ),

                // Medium floating circle - middle right
                Positioned(
                  top: 100 - _floatingAnimation.value * 1.5,
                  right: -300,
                  child: Transform.rotate(
                    angle: -_rotationAnimation.value * 0.2,
                    child: Transform.scale(
                      scale: _scaleAnimation.value * 0.95,
                      child: Opacity(
                        opacity: _fadeAnimation.value * 0.8,
                        child: TCircularContainer(
                          width: 400,
                          height: 400,
                          backgroundColor: TColors.textWhite.withOpacity(0.08),
                        ),
                      ),
                    ),
                  ),
                ),

                // Small accent circle - top left
                Positioned(
                  top: 50 + _floatingAnimation.value * 0.8,
                  left: -100,
                  child: Transform.scale(
                    scale: _scaleAnimation.value * 1.1,
                    child: Opacity(
                      opacity: _fadeAnimation.value * 0.7,
                      child: TCircularContainer(
                        width: 250,
                        height: 250,
                        backgroundColor: TColors.textWhite.withOpacity(0.06),
                      ),
                    ),
                  ),
                ),

                // Animated dots with different speeds
                Positioned(
                  top: 80 + _floatingAnimation.value * 2,
                  right: 50,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.textWhite.withOpacity(0.4),
                          boxShadow: [
                            BoxShadow(
                              color: TColors.textWhite.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 180 - _floatingAnimation.value * 1.2,
                  right: 100,
                  child: Transform.scale(
                    scale: _scaleAnimation.value * 0.9,
                    child: Opacity(
                      opacity: _fadeAnimation.value * 0.9,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.textWhite.withOpacity(0.35),
                          boxShadow: [
                            BoxShadow(
                              color: TColors.textWhite.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 120 + _floatingAnimation.value * 0.5,
                  left: 80,
                  child: Transform.scale(
                    scale: _scaleAnimation.value * 1.05,
                    child: Opacity(
                      opacity: _fadeAnimation.value * 0.8,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.textWhite.withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: TColors.textWhite.withOpacity(0.15),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Additional small dots for more depth
                Positioned(
                  top: 220 + _floatingAnimation.value * 1.8,
                  left: 150,
                  child: Transform.scale(
                    scale: _scaleAnimation.value * 0.85,
                    child: Opacity(
                      opacity: _fadeAnimation.value * 0.6,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.textWhite.withOpacity(0.25),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 160 - _floatingAnimation.value * 0.7,
                  right: 180,
                  child: Transform.scale(
                    scale: _scaleAnimation.value * 0.8,
                    child: Opacity(
                      opacity: _fadeAnimation.value * 0.5,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TColors.textWhite.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                ),

                // Shimmer effect overlay
                Positioned.fill(
                  child: Opacity(
                    opacity: _fadeAnimation.value * 0.15,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(
                            -1.0 + _rotationAnimation.value * 0.1,
                            -1.0,
                          ),
                          end: Alignment(
                            1.0 + _rotationAnimation.value * 0.1,
                            1.0,
                          ),
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.1),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),

                // Content with fade-in animation
                Opacity(opacity: _fadeAnimation.value, child: widget.child),
              ],
            ),
          ),
        );
      },
    );
  }
}
