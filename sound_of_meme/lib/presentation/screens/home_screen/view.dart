import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_of_meme/presentation/screens/home_screen/widgets/widgets.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../../../core/app_fonts.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helpers/helpers.dart';
import '../../../domain/entities/entities.dart';
import '../../../generated/assets.dart';
import '../../app/app.dart';
import '../../widgets/widgets.dart';
import 'home_bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ValueNotifier<int> _bottomIndexNotifier;
  PreloadPageController? _pageController;
  final int _totalPageCount = 3;
  UserDetailsEntity? _userDetailsEntity;

  @override
  void initState() {
    _bottomIndexNotifier = ValueNotifier<int>(0);
    _pageController = PreloadPageController(initialPage: 0);
    context.read<AppBloc>().add(GetUserDetailsEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bottomIndexNotifier.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      bodyColor: context.theme.canvasColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.primary,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(Assets.gifsBluePepe),
        ),
        title: const CustomTextWidget('SoundOfMeme', fontSize: 18),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) {
              if (item == 0) {
                context.intentWithoutBack(RouteConstants.loginScreen);
                context.read<AppBloc>().add(LogOutEvent());
              }
            },
            itemBuilder: (context) => [
               PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: context.theme.textTheme.bodyMedium?.color,),
                    const SizedBox(width: 8),
                    const CustomTextWidget('Logout', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 40),
            color: context.theme.colorScheme.primary,
            child: BlocConsumer<AppBloc, AppState>(
              listener: (context, state) {
                if (state is UserDetailsLoadedState) {
                  _userDetailsEntity = state.userDetailsEntity;
                }
              },
              builder: (context, state) {
                if (_userDetailsEntity == null) {
                  return const CustomRoundShimmerWidget(size: 38);
                }

                return Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CustomTextWidget(
                      _userDetailsEntity?.name.substring(0, 2).capitalize,
                      fontWeight: AppFontsWeightEnum.bold,
                      fontSize: 16,
                      fontColor: Colors.black,
                      style: AppFonts.boldStyle(),
                    ),
                  ),
                );
              },
            ),
          ).paddingOnly(right: 12),
        ],
      ),
      body: Stack(
        children: [
          PreloadPageView(
            preloadPagesCount: _totalPageCount,
            controller: _pageController,
            children: const [
              HomeViewWidget(),
              CreateViewWidget(),
              YourLibraryWidget(),
            ],
            onPageChanged: (final index) {
              _bottomIndexNotifier.value = index;
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BlocBuilder<CurrentSongCubit, CurrentSongState>(
              builder: (context, songState) {
                return MiniPlayerWidget(
                  onPlayPause: () {
                    context.read<CurrentSongCubit>().playPause();
                  },
                  onTap: () {
                    showModalBottomSheet(
                      // useSafeArea: true,
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: context.theme.colorScheme.primary,
                      builder: (modalContext) {
                        return Dismissible(
                          key: const Key('player-widget-bottom-sheet'),
                          direction: DismissDirection.down,
                          onDismissed: (_) => modalContext.back(),
                          child: BlocProvider.value(
                            value: context.read<CurrentSongCubit>(),
                            child: const PlayerWidget(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _bottomIndexNotifier,
        builder: (
          final context,
          final index,
          final notifierWidget,
        ) {
          return BottomNavigationBar(
            elevation: 0,
            backgroundColor: context.theme.primaryColor,
            selectedItemColor: context.theme.colorScheme.secondary,
            unselectedItemColor: context.theme.dividerColor,
            selectedLabelStyle: AppFonts.mediumStyle(
                fontColor: context.theme.colorScheme.secondary),
            unselectedLabelStyle:
                AppFonts.mediumStyle(fontColor: context.theme.dividerColor),
            selectedIconTheme:
                IconThemeData(color: context.theme.colorScheme.onPrimary),
            unselectedIconTheme: IconThemeData(
                color: context.theme.colorScheme.onPrimary.withOpacity(0.6)),
            currentIndex: index,
            onTap: (value) async {
              await _pageController?.animateToPage(
                value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
              );
              _bottomIndexNotifier.value = value;
            },
            items: [
              BottomNavigationBarItem(
                icon: CustomSvgWidget(
                  path: Assets.imagesHome,
                  height: 28,
                  color: _bottomIndexNotifier.value == 0
                      ? context.theme.colorScheme.secondary
                      : context.theme.dividerColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: CustomSvgWidget(
                  path: Assets.imagesCreateSong,
                  height: 28,
                  color: _bottomIndexNotifier.value == 1
                      ? context.theme.colorScheme.secondary
                      : context.theme.dividerColor,
                ),
                label: 'Create',
              ),
              BottomNavigationBarItem(
                icon: CustomSvgWidget(
                  path: Assets.imagesMusic,
                  height: 28,
                  color: _bottomIndexNotifier.value == 2
                      ? context.theme.colorScheme.secondary
                      : context.theme.dividerColor,
                ),
                label: 'My Creations',
              ),
            ],
          );
        },
      ),
    );
  }
}
