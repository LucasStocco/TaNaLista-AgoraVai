import 'package:crud_flutter/views/criar_nova_lista_screen.dart';
import 'package:flutter/material.dart';
import 'minhas_listas_screen.dart';
import 'user_screen.dart';
import 'settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'categorias_screen.dart';
import 'relatorio_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const Center(child: Text('Home', style: TextStyle(fontSize: 24))),
    const CategoriasScreen(),
    const MinhasListasScreen(),
    const RelatorioScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCategoryCard(String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CategoriasScreen()),
        );
      },
      child: Container(
        width: 70,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, width: 50, height: 50),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TOPBAR fixa
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.red,
        title: Text(
          "TáNaLista",
          style: GoogleFonts.delius(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserScreen()),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),

      // CONTEÚDO DO MEIO
      body: _selectedIndex == 0
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Cards aparecem SOMENTE na Home
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCategoryCard(
                          'assets/icons/ic_bebidas.png',
                          'Bebidas',
                        ),
                        _buildCategoryCard(
                          'assets/icons/ic_hortifrut.png',
                          'Hortifrut',
                        ),
                        _buildCategoryCard(
                          'assets/icons/ic_padaria.png',
                          'Padaria',
                        ),
                        _buildCategoryCard(
                          'assets/icons/ic_acougue.png',
                          'Carnes',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  //IMAGEM DE SUPER OFERTA
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/img_super_oferta.jpg',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const SizedBox(height: 24),
                ],
              ),
            )
          : _pages[_selectedIndex],

      // BOTTOM NAVIGATION BAR fixa
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == 2) {
            // "+" abre tela de criar nova lista
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CriarNovaListaScreen()),
            );
          } else if (index > 2) {
            _onItemTapped(index - 1); // ajusta índice porque "+" não é página
          } else {
            _onItemTapped(index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: ''),
        ],
      ),
    );
  }
}
