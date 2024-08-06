import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/helpers/helpers.dart';
import '../home_bloc/home_bloc.dart';
import '../../../widgets/widgets.dart';

class CreateViewWidget extends StatefulWidget {
  const CreateViewWidget({super.key});

  @override
  State<CreateViewWidget> createState() => _CreateViewWidgetState();
}

class _CreateViewWidgetState extends State<CreateViewWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _createSongFormKey = GlobalKey<FormState>();
  final _customSongFormKey = GlobalKey<FormState>();
  final _cloneSongFormKey = GlobalKey<FormState>();
  late TextEditingController _songController;
  late TextEditingController _titleController;
  late TextEditingController _lyricController;
  late TextEditingController _genreController;
  late TextEditingController _promptController;
  late TextEditingController _lyricsController;
  late TextEditingController _fileNameController;
  File? _selectedFile;

  late ValueNotifier<ButtonStateEnum> _buttonStateNotifier;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    _songController = TextEditingController();
    _titleController = TextEditingController();
    _lyricController = TextEditingController();
    _genreController = TextEditingController();
    _promptController = TextEditingController();
    _lyricsController = TextEditingController();
    _fileNameController = TextEditingController();

    _buttonStateNotifier = ValueNotifier(ButtonStateEnum.idle);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _songController.dispose();
    _titleController.dispose();
    _lyricController.dispose();
    _genreController.dispose();
    _promptController.dispose();
    _lyricsController.dispose();
    _fileNameController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      _selectedFile = File(result.files.single.path!);

      _fileNameController.text =
          _selectedFile != null ? _selectedFile!.path.split('/').last : '';
    }
  }

  void _createSong() {
    if (_createSongFormKey.currentState?.validate() ?? false) {
      context.read<HomeBloc>().add(
            CreateSongEvent(
              song: _songController.text,
            ),
          );
    }
  }

  void _createCustomSong() {
    if (_customSongFormKey.currentState?.validate() ?? false) {
      context.read<HomeBloc>().add(
            CreateCustomSongEvent(
              title: _titleController.text,
              lyric: _lyricController.text,
              genre: _genreController.text,
            ),
          );
    }
  }

  void _cloneSong() {
    if ((_cloneSongFormKey.currentState?.validate() ?? false) &&
        _selectedFile != null) {
      context.read<HomeBloc>().add(
            CloneSongEvent(
              file: _selectedFile!,
              prompt: _promptController.text,
              lyrics: _lyricsController.text,
            ),
          );
    } else if (_selectedFile == null) {
      context.showWarning('Please select a file');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is CreateSongLoadingState) {
          _buttonStateNotifier.value = ButtonStateEnum.loading;
        }
        if (state is CreateCustomSongLoadingState) {
          _buttonStateNotifier.value = ButtonStateEnum.loading;
        }
        if (state is CloneSongLoadingState) {
          _buttonStateNotifier.value = ButtonStateEnum.loading;
        }
        if (state is CreateSongErrorState) {
          context.showWarning(state.message);
          _buttonStateNotifier.value = ButtonStateEnum.error;
        }
        if (state is CreateCustomSongErrorState) {
          context.showWarning(state.message);
          _buttonStateNotifier.value = ButtonStateEnum.error;
        }
        if (state is CloneSongErrorState) {
          context.showWarning(state.message);
          _buttonStateNotifier.value = ButtonStateEnum.error;
        }
        if (state is CreateSongLoadedState) {
          context.read<CurrentSongCubit>().updateSong(state.songEntity);
          _songController.clear();
          _buttonStateNotifier.value = ButtonStateEnum.idle;
        }
        if (state is CreateCustomSongLoadedState) {
          context.read<CurrentSongCubit>().updateSong(state.songEntity);
          _titleController.clear();
          _lyricController.clear();
          _genreController.clear();
          _buttonStateNotifier.value = ButtonStateEnum.idle;
        }
        if (state is CloneSongLoadedState) {
          context.read<CurrentSongCubit>().updateSong(state.songEntity);
          _buttonStateNotifier.value = ButtonStateEnum.idle;
        }
      },
      child: CustomScaffoldWidget(
        body: Column(
          children: [
            Container(
              color: context.theme.colorScheme.primary,
              child: TabBar(
                controller: _tabController,
                indicatorColor: context.theme.colorScheme.secondary,
                labelColor: context.theme.colorScheme.secondary,
                unselectedLabelColor: context.theme.colorScheme.onSurface,
                tabs: const [
                  Tab(text: 'Create Song'),
                  Tab(text: 'Custom Song'),
                  Tab(text: 'Clone Song'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCreateSongForm(),
                  _buildCustomSongForm(),
                  _buildCloneSongForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateSongForm() {
    return Form(
      key: _createSongFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFieldWidget(
                controller: _songController,
                hintText: 'Genre and description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the song';
                  }
                  return null;
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 24.0,
                ),
                isDense: false,
                maxLines: 8,
                minLines: 4,
                showFocusedBorder: true,
              ),
              const SizedBox(height: 20),
              CustomButtonWidget(
                onTap: _createSong,
                title: 'Create Song',
                stateNotifier: _buttonStateNotifier,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomSongForm() {
    return Form(
      key: _customSongFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextFieldWidget(
                controller: _titleController,
                hintText: 'Song Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                controller: _lyricController,
                hintText: 'Lyrics of your song',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the lyric';
                  }
                  return null;
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 24.0,
                ),
                minLines: 4,
                maxLines: 8,
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                controller: _genreController,
                hintText: 'Genre',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the genre';
                  }
                  return null;
                },
                minLines: 2,
                maxLines: 6,
              ),
              const SizedBox(height: 20),
              CustomButtonWidget(
                onTap: _createCustomSong,
                title: 'Create Custom Song',
                stateNotifier: _buttonStateNotifier,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCloneSongForm() {
    return Form(
      key: _cloneSongFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickFile,
                child: AbsorbPointer(
                  child: CustomTextFieldWidget(
                    controller: _fileNameController,
                    hintText: 'Select File',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a file';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                controller: _promptController,
                hintText: 'Prompt',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the prompt';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                controller: _lyricsController,
                hintText: 'Lyrics',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the lyrics';
                  }
                  return null;
                },
                minLines: 4,
                maxLines: 8,
              ),
              const SizedBox(height: 20),
              CustomButtonWidget(
                onTap: _cloneSong,
                title: 'Clone Song',
                stateNotifier: _buttonStateNotifier,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
