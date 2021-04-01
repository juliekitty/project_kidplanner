class Program {
  // Eigenschaften
  String programId;
  String title;
  String descr;
  List<Step> steps;
  // später für DetailView bei bedarf gerne erweitern mit Alter, Ort, etc.

  // Konstruktor
  Program(this.programId, this.title, this.descr, this.steps);
}

class Step {
  // Eigenschaften
  String title;
  double duration;
  String picture;

  // Konstruktor
  Step({this.title, this.duration, this.picture});
}

/// Find a person in the list using firstWhere method.
Program findProgramUsingFirstWhere(List<Program> programs, String programId) {
  // Note (from document):
  // 1. Returns the first element that satisfies
  //    the given predicate test. Iterates through
  //    elements and returns the first to satisfy test.
  // 2. If no element satisfies test, the result of
  //    invoking the orElse function is returned.
  //    If orElse is omitted, it defaults to throwing a StateError.
  final program = programs
      .firstWhere((element) => element.programId == programId, orElse: () {
    return null;
  });
  return program;
}
