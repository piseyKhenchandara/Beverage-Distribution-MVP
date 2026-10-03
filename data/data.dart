
import 'package:ecommerce_b2b/domain/depot.dart';
import 'package:ecommerce_b2b/domain/depotManager.dart';
import 'package:ecommerce_b2b/domain/depotOwner.dart';
import 'package:ecommerce_b2b/domain/product.dart';
import 'package:ecommerce_b2b/domain/productImage.dart';

class Data {

  static final List<ProductImage> productImages = [
    ProductImage("PI001", "P001", "assets/products/cambodia_beer_black.png"),
    ProductImage("PI002", "P001", "assets/products/cambodia_beer_blue.png"),
    ProductImage("PI003", "P001", "assets/products/camobodia_beer_red.png"),
    ProductImage("PI004", "P002", "assets/products/cambdiawater0.5.png"),
    ProductImage("PI005", "P003", "assets/products/cambodiawater1.5.png"),
    ProductImage("PI006", "P004", "assets/products/express.png"),
    ProductImage("PI007", "P005", "assets/products/ize.png"),
  ];

  static final List<Product> products = [
    Product("P001", "Cambodia Beer"),
    Product("P002", "Cambodia Water 0.5L"),
    Product("P003", "Cambodia Water 1.5L"),
    Product("P004", "Express"),
    Product("P005", "Ize"),
  ];

  static final List<DepotManager> managers = [
    DepotManager(id: "MGR001", phone: "012345678", name: "Sokha",   isActive: true, createdAt: DateTime(2024, 1, 1)),
    DepotManager(id: "MGR002", phone: "012345679", name: "Dara",    isActive: true, createdAt: DateTime(2024, 1, 5)),
    DepotManager(id: "MGR003", phone: "012345680", name: "Bopha",   isActive: true, createdAt: DateTime(2024, 2, 1)),
    DepotManager(id: "MGR004", phone: "012345681", name: "Chantrea", isActive: true, createdAt: DateTime(2024, 3, 1)),
    DepotManager(id: "MGR005", phone: "012345682", name: "Makara",  isActive: true, createdAt: DateTime(2024, 4, 1)),
  ];

  static final List<DepotOwner> depotOwners = [
    DepotOwner(depotId: "D001", id: "OWN001", phone: "010123456", name: "Vannak",  isActive: true, createdAt: DateTime(2023, 6, 1)),
    DepotOwner(depotId: "D002", id: "OWN002", phone: "010123457", name: "Sothy",   isActive: true, createdAt: DateTime(2023, 6, 15)),
    DepotOwner(depotId: "D003", id: "OWN003", phone: "010123458", name: "Pich",    isActive: true, createdAt: DateTime(2023, 7, 1)),
    DepotOwner(depotId: "D004", id: "OWN004", phone: "010123459", name: "Nimol",   isActive: true, createdAt: DateTime(2023, 8, 1)),
    DepotOwner(depotId: "D005", id: "OWN005", phone: "010123460", name: "Kunthea", isActive: true, createdAt: DateTime(2023, 9, 1)),
  ];

  static final List<Depot> depots = [
    Depot(id: "D001", name: "Takhmao Depot",       location: "Kandal Takhmao",   managerId: "MGR001"),
    Depot(id: "D002", name: "Kien Svay Depot",      location: "Kien Svay",        managerId: "MGR001"),
    Depot(id: "D003", name: "Angk Snuol Depot",     location: "Angk Snuol",       managerId: "MGR001"),
    Depot(id: "D004", name: "Lvea Aem Depot",       location: "Lvea Aem",         managerId: "MGR001"),
    Depot(id: "D005", name: "Kandal Stueng Depot",  location: "Kandal Stueng",    managerId: "MGR001"),
    Depot(id: "D006", name: "Kaoh Thum Depot",      location: "Kaoh Thum",        managerId: "MGR001"),
    Depot(id: "D007", name: "Khsach Kandal Depot",  location: "Khsach Kandal",    managerId: "MGR001"),
    Depot(id: "D008", name: "Mukh Kampul Depot",    location: "Mukh Kampul",      managerId: "MGR001"),
    Depot(id: "D009", name: "Ponhea Lueu Depot",    location: "Ponhea Lueu",      managerId: "MGR002"),
    Depot(id: "D010", name: "S'ang Depot",          location: "S'ang",            managerId: "MGR002"),
    Depot(id: "D011", name: "Leuk Daek Depot",      location: "Leuk Daek",        managerId: "MGR002"),
    Depot(id: "D012", name: "Takhmao North Depot",  location: "Takhmao North",    managerId: "MGR002"),
    Depot(id: "D013", name: "Takhmao South Depot",  location: "Takhmao South",    managerId: "MGR003"),
    Depot(id: "D014", name: "Kien Svay East Depot", location: "Kien Svay East",   managerId: "MGR004"),
    Depot(id: "D015", name: "Kandal Central Depot", location: "Kandal Central",   managerId: "MGR005"),
  ];

}
