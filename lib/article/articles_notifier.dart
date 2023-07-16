import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifier_practice/article/article.dart';
import 'package:notifier_practice/filter/filter_word_state.dart';
import 'package:notifier_practice/mode/mode_state.dart';
import 'package:notifier_practice/repository/articles_repository.dart';

/// [AsyncNotifierProvider] which provides all articles
final articlesProvider = AsyncNotifierProvider<ArticlesNotifier, List<Article>>(
    ArticlesNotifier.new);

class ArticlesNotifier extends AsyncNotifier<List<Article>> {
  // some fields for internal logic
  String? _someString;
  bool _someFlag = false;

  @override
  Future<List<Article>> build() async {
    final mode = ref.watch(modeState);

    return await ArticlesRepository().fetch(mode);
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    final reloaded = await ArticlesRepository().fetch(
      ref.read(modeState),
    );
    state = AsyncValue.data(reloaded);
  }

  void someMethod() {
    // some method maintaining state
  }
}

/// [FutureProvider] which watches [articlesProvider] and [filterWordState]
/// to provide filtered articles for UI.
final filteredArticlesProvider = FutureProvider<List<Article>>((ref) async {
  final filterWord = ref.watch(filterWordState);
  final articles = await ref.watch(articlesProvider.future);

  return articles
      .where((article) => article.title.contains(filterWord))
      .toList();
});

/// [NotifierProvider] which is listening [filteredArticlesProvider]
/// to detect and notify updates.
final hasUpdateProvider = NotifierProvider<ArticlesHasUpdateNotifier, bool>(
    ArticlesHasUpdateNotifier.new);

class ArticlesHasUpdateNotifier extends Notifier<bool> {
  @override
  bool build() {
    ref.listen(filteredArticlesProvider, (previous, next) async {
      if (next.isLoading) {
        state = false;
        return;
      }
      final old = previous?.value ?? [];
      final current = next.value ?? [];
      state = _detectUpdate(old, current);
    });

    return false;
  }

  bool _detectUpdate(List<Article> old, List<Article> current) {
    // some logic for detecting if new articles contained.
    return current.hashCode.isEven;
  }
}
