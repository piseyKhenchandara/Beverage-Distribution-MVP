enum AppRole {
  depot("Depot", "/depotOwner"),
  depotManager("Depot Manager", "/depot_manager"),
  driver("Driver", "/driver");

  final String label;
  final String path;
  const AppRole(this.label, this.path);
}


