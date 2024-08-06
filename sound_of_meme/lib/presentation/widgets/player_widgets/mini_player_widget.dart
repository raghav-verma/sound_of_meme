import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/extensions.dart';
import '../widgets.dart';

class MiniPlayerWidget extends StatelessWidget {
  final void Function() onTap;
  final void Function() onPlayPause;

  const MiniPlayerWidget({
    super.key,
    required this.onTap,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurrentSongCubit>();
    final player = cubit.getPlayer;

    return BlocBuilder<CurrentSongCubit, CurrentSongState>(
      builder: (context, state) {
        if (state.currentSong == null) {
          return const SizedBox();
        }

        return InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                height: 66,
                padding: const EdgeInsets.all(8),
                width: context.screenWidth,
                decoration: BoxDecoration(
                  color: context.theme.primaryColor.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: 'music-image',
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(state.currentSong!.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.currentSong!.songName,
                              style: context.theme.textTheme.bodyMedium?.copyWith(
                                color: context.theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              state.currentSong!.userId,
                              style: context.theme.textTheme.bodySmall?.copyWith(
                                color: context.theme.colorScheme.onPrimary.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).paddingOnly(left: 4, top: 4, bottom: 4),
                    IconButton(
                      onPressed: onPlayPause,
                      icon: Icon(
                        state.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: context.theme.colorScheme.onPrimary,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Duration>(
                stream: player.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration = player.duration ?? Duration.zero;
                  double sliderValue =
                      position.inMilliseconds / (duration.inMilliseconds + 1);

                  return Positioned(
                    bottom: 1,
                    left: 12,
                    child: Center(
                      child: SizedBox(
                        width: context.screenWidth - 36,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: context.theme.colorScheme.onPrimary.withOpacity(0.7),
                            inactiveTrackColor: context.theme.colorScheme.onPrimary.withOpacity(0.2),
                            trackHeight: 4,
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape: SliderComponentShape.noThumb,
                          ),
                          child: Slider(
                            value: sliderValue > 1 ? 1 : sliderValue,
                            min: 0,
                            max: 1,
                            onChanged: (val) {
                              sliderValue = val;
                            },
                            onChangeEnd: cubit.seek,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
