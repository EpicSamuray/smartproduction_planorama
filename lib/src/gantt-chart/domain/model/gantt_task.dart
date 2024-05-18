class GanttTask {
  final DateTime start;
  final DateTime? end;
  final Duration? duration;
  final String label;

  GanttTask({
    required this.start,
    this.end,
    this.duration,
    required this.label,
  }) : assert(
          (end != null && duration == null) ||
              (end == null && duration != null),
          'Either end or duration must be provided, but not both',
        );

  DateTime get calculatedEnd => end ?? start.add(duration!);
  Duration get calculatedDuration =>
      duration ?? calculatedEnd.difference(start);
}
