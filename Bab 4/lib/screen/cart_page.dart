import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Category> categories = [
    Category(
      name: "Fashion",
      items: [
        CartItem(
          gambar: "assets/images/Hoodiee.jpg",
          judul: "Hoodie",
          deskripsi: "Puma",
          harga: 25,
          jumlah: 1,
        ),
        CartItem(
          gambar: "assets/images/baju.jpg",
          judul: "Shoes",
          deskripsi: "Nike",
          harga: 50,
          jumlah: 1,
        ),
      ],
    ),
    Category(
      name: "Elektronik",
      items: [
        CartItem(
          gambar: "assets/images/Watch.jpg",
          judul: "Watch",
          deskripsi: "Rolex",
          harga: 20,
          jumlah: 1,
        ),
        CartItem(
          gambar: "assets/images/Airpods.jpg",
          judul: "Airpods",
          deskripsi: "Apple",
          harga: 333,
          jumlah: 1,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void deleteItem(Category category, CartItem item) {
    setState(() {
      category.items.remove(item);
    });
  }

  double getSubtotal(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + item.harga * item.jumlah);
  }

  double getDiscount(List<CartItem> items) {
    double subtotal = getSubtotal(items);
    return subtotal > 100 ? 10 : 0;
  }

  double getTotal(List<CartItem> items) {
    return getSubtotal(items) - getDiscount(items) + 5;
  }

  void showCheckoutSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sudah Checkout!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Keranjang",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: categories.map((category) {
            return Tab(text: category.name);
          }).toList(),
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories.map((category) {
          return buildCategorySection(category);
        }).toList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Subtotal, Diskon, dan Biaya Pengiriman
              _buildCheckoutDetail("Subtotal", "Rp${getSubtotal(_getAllItems()).toStringAsFixed(2)}", false),
              _buildCheckoutDetail("Diskon", "-Rp${getDiscount(_getAllItems()).toStringAsFixed(2)}", true),
              _buildCheckoutDetail("Biaya Pengiriman", "Rp5.000", false),
              const Divider(thickness: 1, color: Colors.grey),
              _buildCheckoutDetail("Total", "Rp${getTotal(_getAllItems()).toStringAsFixed(2)}", true),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: showCheckoutSnackbar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 152, 134, 255),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<CartItem> _getAllItems() {
    return categories.fold([], (acc, category) => acc..addAll(category.items));
  }

  Widget buildCategorySection(Category category) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        Text(
          category.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...category.items.map((item) => ListItem(
              item: item,
              onQuantityChanged: (quantity) {
                setState(() {
                  item.jumlah = quantity;
                });
              },
              onDelete: () => deleteItem(category, item),
            )),
      ],
    );
  }

  Widget _buildCheckoutDetail(String label, String value, bool isTotal) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isTotal ? Colors.black : Colors.black.withOpacity(0.6),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final List<CartItem> items;

  Category({required this.name, required this.items});
}

class CartItem {
  final String gambar;
  final String judul;
  final String deskripsi;
  final int harga;
  int jumlah;

  CartItem({
    required this.gambar,
    required this.judul,
    required this.deskripsi,
    required this.harga,
    this.jumlah = 1,
  });
}

class ListItem extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onDelete;

  const ListItem({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item.gambar,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.judul,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(item.deskripsi, style: const TextStyle(fontSize: 14)),
                  Text(
                    "Rp${item.harga * item.jumlah}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.blue),
                  onPressed: () {
                    if (item.jumlah > 1) {
                      onQuantityChanged(item.jumlah - 1);
                    }
                  },
                ),
                Text(
                  item.jumlah.toString(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    onQuantityChanged(item.jumlah + 1);
                  },
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: (){
                onQuantityChanged(0);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Item dihapus"),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
