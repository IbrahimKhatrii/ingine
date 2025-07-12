part of '../../engine.dart';

/// Abstract base class for implementing custom painters used in [ICanvas].
///
/// [IPainter] handles painting, animation controllers, and repaint management.
/// Extend this class to create animated or interactive canvas effects.
abstract class IPainter {
  /// Creates an instance of [IPainter].
  ///
  /// This is an abstract class used to define custom canvas painters for ICanvas.
  IPainter();

  /// The current width of the canvas.
  double width = 0;

  /// The current height of the canvas.
  double height = 0;

  /// The center point of the canvas.
  Offset center = Offset.zero;

  /// List of active [AnimationController]s used by this painter.
  final List<AnimationController> controllers = [];

  /// List of active [Animation]s, primarily used for double interpolations.
  final List<Animation<double>> animations = [];

  /// Internal notifier used to trigger repainting.
  ValueNotifier<bool>? _repaintNotifier;

  /// Initializes the painter with canvas dimensions and setup information.
  ///
  /// - [width], [height]: Canvas dimensions
  /// - [center]: Center of the canvas
  /// - [vsync]: A [TickerProvider] used for animations
  /// - [repaintNotifier]: Notifier to trigger UI repaint
  /// - [isFirstInilize]: Indicates if this is the first time being initialized
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

  /// Override this method to perform setup such as creating animations.
  ///
  /// Called only during first initialization.
  void onInit(TickerProvider vsync);

  /// Creates and manages an [AnimationController].
  ///
  /// - [vsync]: Ticker provider
  /// - [duration]: Duration of the animation
  /// - [repeat]: Whether the animation should repeat
  /// - [reverse]: Whether the animation should reverse
  /// - [listener]: Optional listener to be called on animation update
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

  /// Creates and manages a tween-based [Animation] from a given controller.
  ///
  /// If the tween is of type `double`, it will be stored in [animations] list
  /// to allow custom control or synchronization.
  ///
  /// - [vsync]: Ticker provider (not used directly, but for consistency)
  /// - [controller]: Animation controller
  /// - [tween]: Tween definition
  /// - [listener]: Optional listener on animation updates
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

  /// Triggers a repaint by toggling the repaint notifier.
  ///
  /// This can be called inside animations or timers to update the canvas.
  void update() {
    _repaintNotifier?.value = !_repaintNotifier!.value;
  }

  /// Renders the custom drawing logic on the given [Canvas] and [Size].
  ///
  /// This method must be overridden by subclasses.
  void render(Canvas canvas, Size size);

  /// Disposes all animation controllers and clears associated data.
  ///
  /// Should be called when the painter is no longer in use.
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    controllers.clear();
    animations.clear();
  }

  /// Whether the painter should repaint on every frame.
  ///
  /// Override to optimize conditional repainting.
  bool get shouldRepaint => true;
}
