import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';
import 'dart:ui';

import '../../../domain/entities/entities.dart';
import '../widgets/custom_spacer_widget.dart';
import '../../../core/extensions/extensions.dart';
import 'custom_text_widget.dart';
import 'player_widgets/player_widgets.dart';

class SongCardWidget extends StatefulWidget {
  final SongEntity song;
  final bool isSelected;
  final bool isPlaying;

  const SongCardWidget({
    required this.song,
    required this.isSelected,
    required this.isPlaying,
    super.key,
  });

  @override
  State<SongCardWidget> createState() => _SongCardWidgetState();
}

class _SongCardWidgetState extends State<SongCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _circleExpansion;
  late Animation<double> _ringSeparation;
  late Animation<double> _ringThickness;
  late Animation<double> _opacity;
  late Animation<Color?> _shadowColorAnimation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    // Slower disco shadow color animation
    _shadowColorAnimation = ColorTween(
      begin: Colors.green.withOpacity(0.5),
      end: _getRandomColor(),
    ).animate(_animationController);

    _animationController.addListener(() {
      if (widget.isPlaying) {
        setState(() {
          _shadowColorAnimation = ColorTween(
            begin: _getRandomColor(),
            end: _getRandomColor(),
          ).animate(_animationController);
        });
      }
    });

    // Circle expansion into a ring
    _circleExpansion = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 30.0) // Half the previous size
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween:
            Tween(begin: 30.0, end: 40.0) // Adjust the final size accordingly
                .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25.0,
      ),
    ]).animate(_animationController);

    // Ring thickness change and separation
    _ringThickness = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 2.5) // Reduced thickness
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
    ]).animate(_animationController);

    // Opacity animation for fading out the rings
    _opacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween(1.0),
        weight: 80.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20.0,
      ),
    ]).animate(_animationController);

    // Ring separation into two rings
    _ringSeparation = TweenSequence<double>([
      TweenSequenceItem(
        tween: ConstantTween(0.0),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween:
            Tween(begin: 0.0, end: 10.0) // Adjusted separation for smaller size
                .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25.0,
      ),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getRandomColor() {
    return Color.fromRGBO(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurrentSongCubit>();
    final player = cubit.getPlayer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          shadowColor: widget.isPlaying
              ? _shadowColorAnimation.value
              : Colors.green.withOpacity(0.5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.isSelected ? Colors.transparent : Colors.green,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: widget.isPlaying
                      ? _shadowColorAnimation.value!
                      : Colors.green.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6), // Match border radius
                  child: Image.network(
                    widget.song.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (widget.isSelected)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: StreamBuilder<PlayerState>(
                            stream: player.playerStateStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final playerState = snapshot.data;
                                if (playerState?.processingState ==
                                    ProcessingState.ready) {
                                  return widget.isPlaying
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            _buildCircleToRingAnimation(),
                                            _buildTwoRingAnimation(),
                                          ],
                                        )
                                      : const Icon(
                                          Icons.play_arrow_outlined,
                                          size: 60,
                                          color: Colors.white,
                                        );
                                } else if (playerState?.processingState ==
                                        ProcessingState.loading ||
                                    playerState?.processingState ==
                                        ProcessingState.buffering) {
                                  return const CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                }
                              }
                              return const SizedBox(); // Hide icon until player is ready
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Song name
        CustomTextWidget(
          widget.song.songName,
          fontSize: 14,
        ).paddingOnly(left: 4),
        Wrap(
          spacing: 4.0,
          children: widget.song.tags
              .map(
                (tag) => CustomTextWidget(
                  tag,
                  fontSize: 10,
                ),
              )
              .toList(),
        ).paddingOnly(left: 4),
        Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  size: 22,
                  color: context.theme.textTheme.bodyMedium?.color,
                ),
                const CustomSpacerWidget(width: 4),
                CustomTextWidget(
                  widget.song.views.toString(),
                ),
              ],
            ),
            const CustomSpacerWidget(width: 8),
            Row(
              children: [
                Icon(
                  Icons.favorite,
                  size: 16,
                  color: context.theme.textTheme.bodyMedium?.color,
                ),
                const CustomSpacerWidget(width: 4),
                CustomTextWidget(
                  widget.song.likes.toString(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleToRingAnimation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double size = _circleExpansion.value;
        final double thickness = _ringThickness.value;
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white.withOpacity(0.5), width: thickness),
          ),
        );
      },
    );
  }

  Widget _buildTwoRingAnimation() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double outerSize = _circleExpansion.value + _ringSeparation.value;
        final double innerSize = _circleExpansion.value - _ringSeparation.value;
        return Opacity(
          opacity: _opacity.value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Ring
              if (outerSize > 0)
                Container(
                  width: outerSize,
                  height: outerSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: _ringThickness.value,
                    ),
                  ),
                ),
              // Inner Ring
              if (innerSize > 0)
                Container(
                  width: innerSize,
                  height: innerSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: _ringThickness.value,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
