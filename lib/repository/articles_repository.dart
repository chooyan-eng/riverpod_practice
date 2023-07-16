import 'package:notifier_practice/article.dart';
import 'package:notifier_practice/mode/mode_state.dart';

class ArticlesRepository {
  Future<List<Article>> fetch(Mode mode) async {
    // some logic for fetching articles depending on given mode.
    await Future.delayed(const Duration(seconds: 1));
    return [
      Article('Flutter 101', 'eijwAlke03hb'),
      Article('Inside Flutter', '5hjeDD3kruf'),
      Article('Riverpod under the hood', 'jjekblzzjeba'),
      Article('Introduction to Dart', 'eijwAlke03hb'),
      Article('Riverpod v.s. Provider', 'jjekblzzjeba'),
      Article('Architecture of Flutter apps', 'q324gjERJbls'),
    ];
  }
}
