import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifier_practice/article/articles_notifier.dart';
import 'package:notifier_practice/filter/filter_word_state.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() {
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(home: ArticlesPage());
  }
}

class ArticlesPage extends ConsumerWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(filteredArticlesProvider);
    final hasUpdate = ref.watch(hasUpdateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod sample')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) {
                ref.read(filterWordState.notifier).state = value;
              },
            ),
          ),
          const Divider(height: 32),
          if (hasUpdate)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                  child: Text(
                'NEW ARTICLES',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              )),
            ),
          Expanded(
            child: articles.maybeWhen(
              orElse: () => const Center(child: CircularProgressIndicator()),
              data: (data) => RefreshIndicator(
                onRefresh: () async {
                  ref.read(articlesProvider.notifier).reload();
                },
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(data[index].title),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
