part of '../../engine.dart';

/// IPainter is abstract class for Painting on ICanvas
abstract class IPainter {
  double width = 0;
  double height = 0;
  Offset center = Offset.zero;
  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];
  ValueNotifier<bool>? _repaintNotifier;

  void initialize({
    required double width,
    required double height,
    required Offset center,
    required TickerProvider vsync,
    required ValueNotifier<bool> repaintNotifier,
    required bool isFirstInilize,
  }) {
    this.width = width;
    this.height = height;
    this.center = center;
    _repaintNotifier = repaintNotifier;

    if (isFirstInilize) onInit(vsync);
  }

  /// Override this to create animations
  void onInit(TickerProvider vsync);

  /// Creates and manages an animation controller
  AnimationController createController({
    required TickerProvider vsync,
    required Duration duration,
    bool repeat = true,
    bool reverse = false,
    VoidCallback? listener,
  }) {
    final controller = AnimationController(vsync: vsync, duration: duration);

    if (repeat) {
      controller.repeat(reverse: reverse);
    } else {
      controller.forward();
    }

    if (listener != null) {
      controller.addListener(listener);
    }

    controllers.add(controller);
    return controller;
  }

  /// Creates and manages a tween animation
  Animation<T> createAnimation<T>({
    required TickerProvider vsync,
    required AnimationController controller,
    required Tween<T> tween,
    VoidCallback? listener,
  }) {
    final animation = tween.animate(controller);

    if (listener != null) {
      animation.addListener(listener);
    }

    if (T == double) {
      animations.add(animation as Animation<double>);
    }

    return animation;
  }

  void update() {
    _repaintNotifier?.value = !_repaintNotifier!.value;
  }

  void render(Canvas canvas, Size size);

  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    controllers.clear();
    animations.clear();
  }

  bool get shouldRepaint => true;
}
