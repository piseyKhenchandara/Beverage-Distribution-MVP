
import 'package:ecommerce_b2b/domain/depot.dart';
import 'package:ecommerce_b2b/domain/depot_manager.dart';
import 'package:ecommerce_b2b/domain/depot_owner.dart';
import 'package:ecommerce_b2b/domain/enum.dart';
import 'package:ecommerce_b2b/domain/order_item.dart';
import 'package:ecommerce_b2b/domain/order_req.dart';
import 'package:ecommerce_b2b/domain/driver.dart';
import 'package:ecommerce_b2b/domain/product.dart';
import 'package:ecommerce_b2b/domain/product_image.dart';

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
    DepotManager(id: "MGR001", phone: "012345678", name: "Sokha Depot Manager",   isActive: true, createdAt: DateTime(2024, 1, 1)),
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
    DepotOwner(depotId: "D006", id: "OWN006", phone: "010123461", name: "Ratha",   isActive: true, createdAt: DateTime(2023, 9, 15)),
    DepotOwner(depotId: "D007", id: "OWN007", phone: "010123462", name: "Sreymom", isActive: true, createdAt: DateTime(2023, 10, 1)),
    DepotOwner(depotId: "D008", id: "OWN008", phone: "010123463", name: "Kosal",   isActive: true, createdAt: DateTime(2023, 10, 15)),
    DepotOwner(depotId: "D009", id: "OWN009", phone: "010123464", name: "Channary",isActive: true, createdAt: DateTime(2023, 11, 1)),
    DepotOwner(depotId: "D010", id: "OWN010", phone: "010123465", name: "Virak",   isActive: true, createdAt: DateTime(2023, 11, 15)),
    DepotOwner(depotId: "D011", id: "OWN011", phone: "010123466", name: "Sokly",   isActive: true, createdAt: DateTime(2023, 12, 1)),
    DepotOwner(depotId: "D012", id: "OWN012", phone: "010123467", name: "Davan",   isActive: true, createdAt: DateTime(2023, 12, 15)),
    DepotOwner(depotId: "D013", id: "OWN013", phone: "010123468", name: "Malis",   isActive: true, createdAt: DateTime(2024, 1, 1)),
    DepotOwner(depotId: "D014", id: "OWN014", phone: "010123469", name: "Pisey",   isActive: true, createdAt: DateTime(2024, 1, 15)),
    DepotOwner(depotId: "D015", id: "OWN015", phone: "010123470", name: "Borey",   isActive: true, createdAt: DateTime(2024, 2, 1)),
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

  static final List<Driver> drivers = [
    Driver(carPlateNumber: "KDL-001", depotId: "D001", managerId: "MGR001", id: "DRV001", phone: "0971111001", name: "Sokun Driver",  isActive: true, createdAt: DateTime(2024, 1, 1),  lastLogin: DateTime(2026, 10, 1)),
    Driver(carPlateNumber: "KDL-002", depotId: "D001", managerId: "MGR001", id: "DRV002", phone: "0971111002", name: "Nara",   isActive: true, createdAt: DateTime(2024, 2, 1),  lastLogin: DateTime(2026, 9, 28)),
    Driver(carPlateNumber: "KDL-003", depotId: "D001", managerId: "MGR001", id: "DRV003", phone: "0971111003", name: "Vibol",  isActive: true, createdAt: DateTime(2024, 3, 1),  lastLogin: DateTime(2026, 9, 30)),
    Driver(carPlateNumber: "KDL-004", depotId: "D002", managerId: "MGR001", id: "DRV004", phone: "0971111004", name: "Chhun",  isActive: true, createdAt: DateTime(2024, 3, 15), lastLogin: DateTime(2026, 10, 2)),
    Driver(carPlateNumber: "KDL-005", depotId: "D002", managerId: "MGR001", id: "DRV005", phone: "0971111005", name: "Sreynich",isActive: true, createdAt: DateTime(2024, 4, 1), lastLogin: DateTime(2026, 9, 25)),
    Driver(carPlateNumber: "KDL-006", depotId: "D006", managerId: "MGR001", id: "DRV006", phone: "0971111006", name: "Pho",    isActive: true, createdAt: DateTime(2024, 5, 1),  lastLogin: DateTime(2026, 10, 3)),
  ];

  static final List<OrderReq> orderReqs = [
    OrderReq(id: "ORD001", depotId: "D001", status: OrderStatus.pending,   deliveryDate: DateTime(2026, 10, 5),  createdAt: DateTime(2026, 9, 29)),
  
    OrderReq(id: "ORD003", depotId: "D003", status: OrderStatus.rejected,  deliveryDate: DateTime(2026, 10, 7),  createdAt: DateTime(2026, 9, 30)),
    OrderReq(id: "ORD004", depotId: "D004", status: OrderStatus.completed, deliveryDate: DateTime(2026, 10, 3),  createdAt: DateTime(2026, 10,  12)),
    OrderReq(id: "ORD005", depotId: "D005", status: OrderStatus.cancelled, deliveryDate: DateTime(2026, 10, 2),  createdAt: DateTime(2026, 10,  14)),
    OrderReq(id: "ORD006", depotId: "D001", status: OrderStatus.pending,   deliveryDate: DateTime(2026, 10, 10), createdAt: DateTime(2026, 10, 15)),

  ];

  static final List<OrderItem> orderItems = [
    OrderItem(id: "OI001", orderReqId: "ORD001", productId: "P001", quantity: 50),
    OrderItem(id: "OI002", orderReqId: "ORD001", productId: "P002", quantity: 100),
    OrderItem(id: "OI003", orderReqId: "ORD002", productId: "P003", quantity: 30),
    OrderItem(id: "OI004", orderReqId: "ORD002", productId: "P004", quantity: 20),
    OrderItem(id: "OI005", orderReqId: "ORD003", productId: "P001", quantity: 60),
    OrderItem(id: "OI006", orderReqId: "ORD004", productId: "P005", quantity: 40),
    OrderItem(id: "OI007", orderReqId: "ORD004", productId: "P002", quantity: 80),
    OrderItem(id: "OI008", orderReqId: "ORD005", productId: "P003", quantity: 25),
    OrderItem(id: "OI009", orderReqId: "ORD006", productId: "P001", quantity: 120),
    OrderItem(id: "OI010", orderReqId: "ORD007", productId: "P004", quantity: 15),
  ];

}
