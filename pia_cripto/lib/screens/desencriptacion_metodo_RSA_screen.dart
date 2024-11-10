import 'package:flutter/material.dart';

class DesencriptacionMetodoRSAScreen extends StatefulWidget {
  const DesencriptacionMetodoRSAScreen({super.key});

  @override
  _DesencriptacionMetodoRSAScreenState createState() => _DesencriptacionMetodoRSAScreenState();
}

class _DesencriptacionMetodoRSAScreenState extends State<DesencriptacionMetodoRSAScreen> {
  final TextEditingController _mensajeController = TextEditingController();
  final TextEditingController _pController = TextEditingController();
  final TextEditingController _qController = TextEditingController();
  String _resultado = '';
  String _infoLlaves = '';

  final String abecedario = 'abcdefghijklmnopqrstuvwxyz';

  // Obtener la posición de cada letra en el abecedario personalizado
  int _posicionEnAbecedario(String letra) {
    return abecedario.indexOf(letra);
  }

  String _desencriptarRSA(String mensaje, int p, int q) {
    int n = p * q;
    int phi = (p - 1) * (q - 1);
    int e = 3;

    // Buscar e coprimo con phi y menor que phi
    while (e < phi) {
      if (_gcd(e, phi) == 1) {
        break;
      }
      e++;
    }

    // Calcular d como el inverso multiplicativo de e mod phi
    int d = _modInverse(e, phi);

    // Convertir cada número cifrado en la posición original usando d
    List<String> descifrado = mensaje.split(' ').map((String valor) {
      int posicion = int.tryParse(valor) ?? -1;
      if (posicion >= 0) {
        int posDesencriptada = _modExp(posicion, d, n);
        return abecedario[posDesencriptada];
      }
      return '';
    }).toList();

    // Guardar la información de llaves
    _infoLlaves = 'Llaves públicas: ($e, $n)\n'
                  'Llaves privadas: ($d, $n)\n'
                  '∅(n) = $phi';

    return descifrado.join('');
  }

  int _gcd(int a, int b) => b == 0 ? a : _gcd(b, a % b);

  int _modExp(int base, int exp, int mod) {
    int result = 1;
    base = base % mod;
    while (exp > 0) {
      if (exp % 2 == 1) result = (result * base) % mod;
      exp = exp >> 1;
      base = (base * base) % mod;
    }
    return result;
  }

  int _modInverse(int a, int m) {
    for (int x = 1; x < m; x++) {
      if ((a * x) % m == 1) {
        return x;
      }
    }
    return 1;
  }

  void _desencriptarMensaje() {
    String mensaje = _mensajeController.text;
    int p = int.tryParse(_pController.text) ?? 0;
    int q = int.tryParse(_qController.text) ?? 0;

    if (p > 1 && q > 1) {
      String resultadoDescifrado = _desencriptarRSA(mensaje, p, q);
      setState(() {
        _resultado = resultadoDescifrado;
      });
    } else {
      setState(() {
        _resultado = 'Error: Ingrese números primos válidos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Método RSA - Desencriptación'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.deepPurple,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Ingresa el mensaje a desencriptar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _mensajeController,
                    decoration: InputDecoration(
                      hintText: 'Escribe aquí el mensaje',
                      prefixIcon: const Icon(Icons.message, color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _pController,
                    decoration: InputDecoration(
                      hintText: 'Número primo p',
                      prefixIcon: const Icon(Icons.numbers, color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _qController,
                    decoration: InputDecoration(
                      hintText: 'Número primo q',
                      prefixIcon: const Icon(Icons.numbers, color: Colors.deepPurple),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _desencriptarMensaje,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Desencriptar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
            if (_resultado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Resultado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$_resultado\n$_infoLlaves',
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
