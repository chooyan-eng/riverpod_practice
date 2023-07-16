// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:notifier_practice/article.dart';
// import 'package:notifier_practice/filter/filter_word_state.dart';
// import 'package:notifier_practice/mode/mode_state.dart';
// import 'package:notifier_practice/repository/articles_repository.dart';

// final articlesProvider =
//     AsyncNotifierProvider<ArticlesNotifier, ArticleState>(ArticlesNotifier.new);

// class ArticleState {
//   ArticleState(
//     this.articles,
//     this.hasUpdate,
//   );

//   final List<Article> articles;
//   final bool hasUpdate;
// }

// class ArticlesNotifier extends AsyncNotifier<ArticleState> {
//   List<Article>? _cache;

//   @override
//   Future<ArticleState> build() async {
//     final mode = ref.watch(modeState);
//     final filterWord = ref.read(filterWordState);

//     final articles = await ArticlesRepository().fetch(mode);
//     final filteredArticles = articles
//         .where((article) => article.title.contains(filterWord))
//         .toList();
//     final hasUpdate = _detectUpdate(_cache ?? [], filteredArticles);

//     _cache = articles;

//     ref.listen(filterWordState, (_, next) {
//       if (_cache != null) {
//         final filteredList = _cache!
//             .where((article) => article.title.contains(filterWord))
//             .toList();
//         state = AsyncValue.data(
//           ArticleState(filteredList, _detectUpdate(_cache ?? [], filteredList)),
//         );
//       }
//     });

//     return ArticleState(filteredArticles, hasUpdate);
//   }

//   Future<void> reload() async {
//     final reloaded = await ArticlesRepository().fetch(
//       ref.read(modeState),
//     );
//     state = AsyncValue.data(
//       ArticleState(reloaded, state.value?.hasUpdate ?? false),
//     );
//   }

//   bool _detectUpdate(List<Article> old, List<Article> current) {
//     // some logic for detecting if new articles contained.
//     return true;
//   }
// }
