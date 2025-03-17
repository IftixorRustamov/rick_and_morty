part of '../../screens/character_list_screen.dart';

class _CharacterList extends StatelessWidget {
  final List<CharacterEntity> characters;
  final bool hasNext;
  final ScrollController scrollController;
  final void Function(CharacterEntity) onFavoriteToggle;
  final Future<void> Function() onRefresh;

  const _CharacterList({
    required this.characters,
    required this.hasNext,
    required this.scrollController,
    required this.onFavoriteToggle,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        itemCount: characters.length + (hasNext ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == characters.length) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: BaseIndicator(),
            );
          }
          final character = characters[index];
          return CharacterCard(
            key: ValueKey(character.id), // Ensure rebuild on state change
            character: character,
            onFavoriteToggle: () => onFavoriteToggle(character),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _ErrorView({required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
