import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/common/components/base_indicator.dart';
import 'package:rick_and_morty/src/presentation/bloc/character_bloc.dart';
import 'package:rick_and_morty/src/presentation/bloc/character_event.dart';
import 'package:rick_and_morty/src/presentation/bloc/character_state.dart';
import '../../domain/entities/characters/character_entity.dart';
import '../_widgets/character_card.dart';

part "../_widgets/character_list/character_list_wgs.dart";

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(const LoadCharacters(1));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !context.read<CharacterBloc>().state.isLoading) {
      final state = context.read<CharacterBloc>().state;
      if (state.characters?.next != null) {
        _currentPage++;
        context.read<CharacterBloc>().add(LoadCharacters(_currentPage));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) => _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CharacterState state) {
    if (_isInitialLoading(state)) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.errorMessage != null) {
      return _ErrorView(errorMessage: state.errorMessage!, onRetry: _retry);
    }
    if (_isEmpty(state)) {
      return const Center(child: Text('No characters available'));
    }
    return _CharacterList(
      characters: state.characters!.results,
      hasNext: state.characters!.next != null,
      scrollController: _scrollController,
      onFavoriteToggle:
          (character) =>
              context.read<CharacterBloc>().add(ToggleFavorite(character)),
      onRefresh: _refresh,
    );
  }

  bool _isInitialLoading(CharacterState state) =>
      state.isLoading &&
      (state.characters == null || state.characters!.results.isEmpty);

  bool _isEmpty(CharacterState state) =>
      state.characters == null || state.characters!.results.isEmpty;

  void _retry() {
    _currentPage = 1;
    context.read<CharacterBloc>().add(const LoadCharacters(1));
  }

  Future<void> _refresh() async {
    _currentPage = 1;
    context.read<CharacterBloc>().add(const LoadCharacters(1));
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
