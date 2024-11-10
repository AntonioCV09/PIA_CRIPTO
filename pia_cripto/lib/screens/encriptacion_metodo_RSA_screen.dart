import 'package:flutter/material.dart';

class EncriptacionMetodoRSAScreen extends StatefulWidget {
  const EncriptacionMetodoRSAScreen({super.key});

  @override
  _EncriptacionMetodoRSAScreenState createState() => _EncriptacionMetodoRSAScreenState();
}

class _EncriptacionMetodoRSAScreenState extends State<EncriptacionMetodoRSAScreen> {
  final TextEditingController _mensajeController = TextEditingController();
  final TextEditingController _pController = TextEditingController();
  final TextEditingController _qController = TextEditingController();
  String _resultado = '';
  String _infoLlaves = '';

  final String abecedario = 'abcdefghijklmnopqrstuvwxyz';

  // Función para obtener la posición de cada letra en el abecedario personalizado
  int _posicionEnAbecedario(String letra) {
    int posicion = abecedario.indexOf(letra);
    if (posicion == -1) {
      print("Letra no encontrada en el abecedario: $letra");
      return -1; // Valor para letras no encontradas
    } else {
      print("Letra: $letra, Posición en abecedario: ${posicion}");
      return posicion; // Retorna la posición real en abecedario (1-based index)
    }
  }

  String _encriptarRSA(String mensaje, int p, int q) {
    int n = p * q;
    int phi = (p - 1) * (q - 1);
    int e = 3;

    // Asegurarse de que e sea coprimo con phi y menor que phi
    while (e < phi) {
      if (_gcd(e, phi) == 1) {
        break;
      }
      e++;
    }

    // Calcular d como el inverso multiplicativo de e mod phi
    int d = _modInverse(e, phi);

    // Convertir cada letra en número del abecedario definido y aplicar encriptación
    List<int> cifrado = mensaje.split('').map((String letra) {
      int posicion = _posicionEnAbecedario(letra);
      return _modExp(posicion, e, n);
    }).toList();

    // Guardar la información de llaves
    _infoLlaves = 'Llaves públicas: ($e, $n)\n'
                  'Llaves privadas: ($d, $n)\n'
                  '∅(n) = $phi';

    return cifrado.join(' ');
  }

  // Calculo de gcd
  int _gcd(int a, int b) {
    return b == 0 ? a : _gcd(b, a % b);
  }

  // Exponenciación modular
  int _modExp(int base, int exp, int mod) {
    int result = 1;
    base = base % mod;
    while (exp > 0) {
      if (exp % 2 == 1) {
        result = (result * base) % mod;
      }
      exp = exp >> 1;
      base = (base * base) % mod;
    }
    return result;
  }

  // Inverso modular
  int _modInverse(int a, int m) {
    for (int x = 1; x < m; x++) {
      if ((a * x) % m == 1) {
        return x;
      }
    }
    return 1;
  }

  void _encriptarMensaje() {
    String mensaje = _mensajeController.text;
    int p = int.tryParse(_pController.text) ?? 0;
    int q = int.tryParse(_qController.text) ?? 0;

    if (p > 1 && q > 1) {
      String resultadoCifrado = _encriptarRSA(mensaje, p, q);
      setState(() {
        _resultado = resultadoCifrado;
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
        title: const Text('Método RSA - Encriptación'),
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
                    'Ingresa el mensaje a encriptar',
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
              onPressed: _encriptarMensaje,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Encriptar',
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
