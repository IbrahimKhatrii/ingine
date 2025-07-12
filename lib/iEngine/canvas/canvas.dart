part of '../../engine.dart';

/// ICanvas is CustomPainter that paints IPainter (a dynamic effecting canvas)
class ICanvas extends StatefulWidget {
  final IPainter painter;

  const ICanvas({super.key, required this.painter});

  @override
  State<ICanvas> createState() => _ICanvasState();
}

class _ICanvasState extends State<ICanvas> with TickerProviderStateMixin {
  bool _initialized = false;
  late final ValueNotifier<bool> _repaintNotifier;

  Size _previousSize = Size.zero;
  bool hasStarted = false;

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

    if (oldWidget.painter != widget.painter) {
      oldWidget.painter.dispose();
      _initialized = false;
    }
  }
}

class _ParticlePainter extends CustomPainter {
  final IPainter effect;

  _ParticlePainter(this.effect);

  @override
  void paint(Canvas canvas, Size size) {
    effect.render(canvas, size);
  }

  @override
  bool shouldRepaint(_) => effect.shouldRepaint;
}
