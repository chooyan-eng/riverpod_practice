import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Mode { home, timeline }

final modeState = StateProvider((ref) => Mode.home);
