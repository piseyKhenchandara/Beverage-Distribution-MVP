enum AppRole {
  depot("Depot", "/depotOwner/:id"),
  depotManager("Depot Manager", "/depot_manager/:id"),
  driver("Driver", "/driver/:id");

  final String label;
  final String path;
  const AppRole(this.label, this.path);
}


