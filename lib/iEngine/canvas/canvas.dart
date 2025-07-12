part of '../../engine.dart';

/// A widget that hosts a custom painting canvas driven by an [IPainter].
///
/// The [ICanvas] dynamically initializes and repaints based on size changes
/// or state updates provided by the [IPainter]. It uses a [ValueNotifier]
/// to trigger repaints and passes animation [TickerProvider] and context-related
/// information to the painter for effects like animation or transformation.
class ICanvas extends StatefulWidget {
  /// The [IPainter] responsible for rendering and animation logic.
  final IPainter painter;

  /// Creates an [ICanvas] widget.
  const ICanvas({super.key, required this.painter});

  @override
  State<ICanvas> createState() => _ICanvasState();
}

class _ICanvasState extends State<ICanvas> with TickerProviderStateMixin {
  /// Indicates whether the canvas has been initialized at least once.
  bool _initialized = false;

  /// Notifies the painter when to repaint.
  late final ValueNotifier<bool> _repaintNotifier;

  /// Stores the last known size of the canvas.
  Size _previousSize = Size.zero;

  /// Ensures `isFirstInitialize` is passed properly on the first frame.
  bool hasStarted = false;

  /// Initializes the painter if needed (first run or size changed).
  void _initializeIfNeeded(BoxConstraints constraints) {
    final currentSize = Size(constraints.maxWidth, constraints.maxHeight);

    if (!_initialized || _previousSize != currentSize) {
      _previousSize = currentSize;

      final center = Offset(currentSize.width / 2, currentSize.height / 2);

      widget.painter.initialize(
        width: currentSize.width,
        height: currentSize.height,
        center: center,
        vsync: this,
        repaintNotifier: _repaintNotifier,
        isFirstInilize: _initialized ? !hasStarted : true,
      );

      _initialized = true;
      hasStarted = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _repaintNotifier = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, constraints) {
      _initializeIfNeeded(constraints);

      return ValueListenableBuilder<bool>(
        valueListenable: _repaintNotifier,
        builder:
            (_, __, ___) => CustomPaint(
              painter: _ParticlePainter(widget.painter),
              child: const SizedBox.expand(),
            ),
      );
    },
  );

  @override
  void dispose() {
    widget.painter.dispose();
    _repaintNotifier.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ICanvas oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reinitialize if painter has changed
    if (oldWidget.painter != widget.painter) {
      oldWidget.painter.dispose();
      _initialized = false;
    }
  }
}

/// A custom painter that delegates painting to the given [IPainter].
///
/// This is the bridge that connects the [CustomPaint] with the actual
/// drawing logic defined inside [IPainter].
class _ParticlePainter extends CustomPainter {
  /// The effect engine responsible for rendering the canvas.
  final IPainter effect;

  /// Creates a [_ParticlePainter] with the given [IPainter].
  _ParticlePainter(this.effect);

  @override
  void paint(Canvas canvas, Size size) {
    effect.render(canvas, size);
  }

  @override
  bool shouldRepaint(_) => effect.shouldRepaint;
}
