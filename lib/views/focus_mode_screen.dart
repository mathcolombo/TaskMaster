import 'package:flutter/material.dart';
import 'package:task_master/views/widgets/bottom_navigation_bar_custom.dart';

const String _focusImagePath = 'assets/images/focus_image.png';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {

  bool _isFocusModeActive = false;
  final int _selectedIndex = 4;

  bool _isPressing = false;
  DateTime? _pressStartTime;

  @override
  void initState() {
    super.initState();
  }

  void _activateFocusMode() {
    setState(() {
      _isFocusModeActive = true;
    });
    debugPrint('Modo Foco Ativado!');
  }

  void _deactivateFocusMode() {
    setState(() {
      _isFocusModeActive = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Modo Foco desativado.'),
        duration: Duration(seconds: 2),
      ),
    );
    debugPrint('Modo Foco Desativado!');
  }

  void _onLongPressStart(LongPressStartDetails details) {
    if (_isFocusModeActive) {
      _isPressing = true;
      _pressStartTime = DateTime.now();
      _checkLongPress();
      debugPrint('Long press iniciado.');
    }
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    _isPressing = false;
    _pressStartTime = null;
    debugPrint('Long press finalizado.');
  }

  void _checkLongPress() async {
    while (_isPressing && _isFocusModeActive && _pressStartTime != null) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (!_isPressing || !_isFocusModeActive) {
        return;
      }
      if (DateTime.now().difference(_pressStartTime!).inSeconds >= 2) {
        if (_isFocusModeActive) {
          _deactivateFocusMode();
        }
        _isPressing = false;
        _pressStartTime = null;
        return;
      }
    }
  }

  void _handleBottomNavTap(int index, BuildContext navContext) {
    if (_isFocusModeActive && index != _selectedIndex) {
      return;
    }
    BottomNavigationBarCustom.navigate(index, navContext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isFocusModeActive ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text(
          'Foco mode',
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: _isFocusModeActive ? Colors.black : Colors.transparent,
        elevation: 0,
        leading: _isFocusModeActive
            ? null
            : IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 30),
                onPressed: () {
                  BottomNavigationBarCustom.navigate(0, context);
                },
              ),
      ),
      body: GestureDetector(
        onLongPressStart: _onLongPressStart,
        onLongPressEnd: _onLongPressEnd,
        child: Stack(
          children: [
            if (_isFocusModeActive)
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
            if (_isFocusModeActive)
              Center(
                child: Opacity(
                  opacity: 0.15,
                  child: Image.asset(
                    _focusImagePath,
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                    color: Colors.white,
                    colorBlendMode: BlendMode.modulate,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Erro ao carregar imagem no modo foco: $error');
                      return const Icon(Icons.error, color: Colors.red, size: 250);
                    },
                  ),
                ),
              ),
            if (!_isFocusModeActive)
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _focusImagePath,
                            width: 200,
                            height: 200,
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint('Erro ao carregar imagem no modo normal: $error');
                              return const Icon(Icons.error, color: Colors.red, size: 200);
                            },
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              children: [
                                const Text(
                                  'Pressione o botão abaixo para entrar no modo foco.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'No modo foco, o celular ficará em uma tela preta e sairá apenas ao pressionar e segurar a imagem de fundo por 2 segundos.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100.0, left: 20.0, right: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _activateFocusMode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff19647E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Foco Mode',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}