import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_of_meme/core/helpers/app_fonts_weight_enum.dart';
import 'dart:ui';
import '../../../core/extensions/extensions.dart';
import '../widgets.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurrentSongCubit>();
    final player = cubit.getPlayer;
    const fixedColor = Colors.white;

    return BlocBuilder<CurrentSongCubit, CurrentSongState>(
      builder: (context, state) {
        if (state.currentSong == null) {
          return Center(
            child: Text(
              "No song playing",
              style: context.theme.textTheme.bodyLarge?.copyWith(
                color: context.theme.primaryColor,
              ),
            ),
          );
        }

        return CustomScaffoldWidget(
          showLeading: false,
          backgroundColor: context.theme.colorScheme.primary,
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        CachedNetworkImageProvider(state.currentSong!.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Hero(
                        tag: 'music-image',
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.currentSong!.imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: context.screenHeight / 2.4,
                          width: context.screenWidth - 60,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      CustomTextWidget(
                        state.currentSong!.songName,
                        fontWeight: AppFontsWeightEnum.bold,
                        fontSize: 20,
                        fontColor: fixedColor,
                      ),
                      CustomTextWidget(
                        state.currentSong!.userId,
                        fontWeight: AppFontsWeightEnum.semiBold,
                        fontSize: 16,
                        fontColor: fixedColor.withOpacity(0.6),
                      ),
                      const CustomSpacerWidget(height: 15),
                      StreamBuilder<Duration>(
                        stream: player.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration = player.duration ?? Duration.zero;
                          double sliderValue = position.inMilliseconds /
                              (duration.inMilliseconds + 1);

                          return Column(
                            children: [
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: fixedColor,
                                  inactiveTrackColor:
                                      fixedColor.withOpacity(0.117),
                                  thumbColor: fixedColor,
                                  trackHeight: 3,
                                  overlayShape: SliderComponentShape.noOverlay,
                                ),
                                child: Slider(
                                  value: sliderValue > 1 ? 1 : sliderValue,
                                  min: 0,
                                  max: 1,
                                  onChanged: (val) {
                                    sliderValue = val;
                                  },
                                  onChangeEnd: (val) {
                                    cubit.seek(val);
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextWidget(
                                    '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                                    fontColor: fixedColor.withOpacity(0.4),
                                    fontSize: 12,
                                    fontWeight: AppFontsWeightEnum.regular,
                                  ),
                                  CustomTextWidget(
                                    '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                    fontColor: fixedColor.withOpacity(0.4),
                                    fontSize: 12,
                                    fontWeight: AppFontsWeightEnum.regular,
                                  ),
                                ],
                              ).paddingSymmetric(horizontal: 12),
                            ],
                          );
                        },
                      ),
                      const CustomSpacerWidget(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.shuffle,
                              color: state.shuffleMode
                                  ? context.theme.colorScheme.secondary
                                  : fixedColor,
                            ),
                            onPressed: cubit.toggleShuffle,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.skip_previous,
                              color: fixedColor,
                            ),
                            onPressed: cubit.previousSong,
                            iconSize: 50,
                          ),
                          StreamBuilder<PlayerState>(
                            stream: player.playerStateStream,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              final processingState =
                                  playerState?.processingState;
                              final playing = playerState?.playing;
                              if (processingState == ProcessingState.loading ||
                                  processingState ==
                                      ProcessingState.buffering) {
                                return Container(
                                  margin: const EdgeInsets.all(8.0),
                                  width: 48.0,
                                  height: 48.0,
                                  child: CircularProgressIndicator(
                                    color: fixedColor,
                                  ),
                                );
                              } else if (playing != true) {
                                return IconButton(
                                  icon: const Icon(Icons.play_circle_filled),
                                  iconSize: 80.0,
                                  onPressed: player.play,
                                  color: fixedColor,
                                );
                              } else if (processingState !=
                                  ProcessingState.completed) {
                                return IconButton(
                                  icon: const Icon(Icons.pause_circle_filled),
                                  iconSize: 80.0,
                                  onPressed: player.pause,
                                  color: fixedColor,
                                );
                              } else {
                                return IconButton(
                                  icon: const Icon(Icons.replay),
                                  iconSize: 80.0,
                                  onPressed: () => player.seek(Duration.zero,
                                      index: player.effectiveIndices!.first),
                                  color: fixedColor,
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.skip_next,
                              color: fixedColor,
                            ),
                            onPressed: cubit.nextSong,
                            iconSize: 50,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.repeat,
                              color: state.repeatMode
                                  ? context.theme.colorScheme.secondary
                                  : fixedColor,
                            ),
                            onPressed: cubit.toggleRepeat,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ).paddingSymmetric(
                vertical: 80,
                horizontal: 8,
              ),
              Positioned(
                top: 40,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: fixedColor,
                  ),
                  iconSize: 50,
                  onPressed: context.back,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
