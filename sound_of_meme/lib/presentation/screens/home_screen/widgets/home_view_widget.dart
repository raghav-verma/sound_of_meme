import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_fonts.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../domain/entities/entities.dart';
import '../../../app/app.dart';
import '../../../widgets/widgets.dart';
import '../home_bloc/home_bloc.dart';

class HomeViewWidget extends StatefulWidget {
  const HomeViewWidget({super.key});

  @override
  State<HomeViewWidget> createState() => _HomeViewWidgetState();
}

class _HomeViewWidgetState extends State<HomeViewWidget> {
  late ValueNotifier<int?> _currentlySelectedIndexNotifier;
  late ValueNotifier<List<SongEntity>> _songListNotifier;
  late ValueNotifier<WidgetStateEnum> _widgetStateNotifier;
  int _currentPage = 1;
  bool _isLoading = false;
  bool _isLastPage = false;

  @override
  void initState() {
    _currentlySelectedIndexNotifier = ValueNotifier<int?>(null);

    _songListNotifier = ValueNotifier<List<SongEntity>>([]);
    _widgetStateNotifier =
        ValueNotifier<WidgetStateEnum>(WidgetStateEnum.loading);

    context.read<HomeBloc>().add(GetAllSongsEvent(page: _currentPage));

    super.initState();
  }

  @override
  void dispose() {
    _currentlySelectedIndexNotifier.dispose();
    _songListNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AllSongsLoadingState) {
          if (_currentPage == 1) {
            _widgetStateNotifier.value = WidgetStateEnum.loading;
          }
        } else if (state is AllSongsErrorState) {
          _widgetStateNotifier.value = WidgetStateEnum.error;
          context.showWarning(state.message);
        } else if (state is AllSongsLoadedState) {
          if (_currentPage > 1) {
            List<SongEntity> currentList = _songListNotifier.value;
            currentList.addAll(state.songList);
            _songListNotifier.value = currentList;
          } else {
            _songListNotifier.value = state.songList;
          }
          _widgetStateNotifier.value = WidgetStateEnum.loaded;
          _isLastPage = state.songList.length < 20;
        }
      },
      child: BlocBuilder<CurrentSongCubit, CurrentSongState>(
        builder: (context, songState) {
          return ValueListenableBuilder<WidgetStateEnum>(
            valueListenable: _widgetStateNotifier,
            builder: (context, state, _) {
              if (state == WidgetStateEnum.loading) {
                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  itemCount: 6, // Number of shimmer cards to display
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: context.isLandScape ? 200 : 300,
                    mainAxisExtent: 280,
                    crossAxisSpacing: 12.0,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomShimmerWidget(
                          height: 180,
                          width: double.infinity,
                          radius: 8,
                        ),
                        const SizedBox(height: 8),
                        CustomShimmerWidget(
                          height: 16,
                          width: context.screenWidth / 2,
                          radius: 4,
                        ).paddingOnly(left: 4),
                        const SizedBox(height: 4),
                        CustomShimmerWidget(
                          height: 12,
                          width: context.screenWidth / 3,
                          radius: 4,
                        ).paddingOnly(left: 4),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const CustomShimmerWidget(
                              height: 16,
                              width: 24,
                              radius: 4,
                            ).paddingOnly(left: 4),
                            const SizedBox(width: 8),
                            const CustomShimmerWidget(
                              height: 16,
                              width: 24,
                              radius: 4,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              } else if (state == WidgetStateEnum.error) {
                return const Center(child: Text('Error loading songs.'));
              }
              return ValueListenableBuilder<List<SongEntity>>(
                valueListenable: _songListNotifier,
                builder: (context, songList, _) {
                  if (songList.isEmpty) {
                    return const Center(
                        child: CustomTextWidget('No songs found.'));
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification sn) {
                      if (!_isLoading &&
                          sn is ScrollUpdateNotification &&
                          sn.metrics.pixels == sn.metrics.maxScrollExtent &&
                          !_isLastPage) {
                        _isLoading = true;
                        _currentPage++;
                        _fetchSongs();
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      displacement: 20,
                      color: context.theme.colorScheme.secondary,
                      backgroundColor: context.theme.canvasColor,
                      onRefresh: () async {
                        _currentPage = 1;
                        context
                            .read<HomeBloc>()
                            .add(GetAllSongsEvent(page: _currentPage));
                      },
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            sliver: SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent:
                                    context.isLandScape ? 200 : 300,
                                mainAxisExtent: 280,
                                crossAxisSpacing: 12.0,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return ValueListenableBuilder<int?>(
                                    valueListenable:
                                        _currentlySelectedIndexNotifier,
                                    builder: (context, selectedIndex, _) {
                                      return InkWell(
                                        onTap: () => _selectSong(index),
                                        child: SongCardWidget(
                                          song: _songListNotifier.value[index],
                                          isSelected: selectedIndex == index,
                                          isPlaying: selectedIndex == index &&
                                              songState.isPlaying,
                                        ),
                                      );
                                    },
                                  );
                                },
                                childCount: songList.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _selectSong(final int index) {
    _currentlySelectedIndexNotifier.value = index;
    context
        .read<SongBloc>()
        .add(ViewSongEvent(id: _songListNotifier.value[index].songId));
    context.read<CurrentSongCubit>().setPlaylist(
          _songListNotifier.value,
          startIndex: index,
        );
  }

  void _fetchSongs() {
    context.read<HomeBloc>().add(GetAllSongsEvent(page: _currentPage));
  }
}
