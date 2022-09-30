class Subroute {
  Subroute({required this.path}) {
    final List<String> splitPath = path.split('/');
    bases = splitPath.sublist(0, -1);
    pathName = splitPath[-1];
    baseUrl = bases.join('/');
  }

  /// A list representation of each section of the base. 
  /// ie the route '/a/new/nav/destination' would be ['a', 'new', 'nav',]
  late List<String> bases;

  /// The path without its base url.  
  /// ie the route '/a/new/nav/destination' would be 'destination'
  late String pathName;
  /// A string representation of the full base url
  /// ie the route '/a/new/nav/destination' would be 'a/new/nav'
  late String baseUrl;
  /// the full path of the url
  /// ie the route '/a/new/nav/destination' would be 'a/new/nav/destination'
  final String path;
}
