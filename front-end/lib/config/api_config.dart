class ApiConfig {
  static const String baseUrl = 'http://localhost:8088';
}


//http://192.168.68.59:8088/listas

// concete o celular via USB no modo dev
// adb reverse tcp:8088 tcp:8088 no terminal 
// flutter clean
// flutter run

/*
🎯 Como funciona agora

Celular → localhost:8088
ADB redireciona → PC:8088
Spring responde

Sem IP.
Sem dor de cabeça.
Sem mudar quando troca Wi-Fi.

🧠 Só lembre de uma coisa

Se você:

Reiniciar o celular

Desconectar o cabo

Reiniciar o PC

Vai precisar rodar novamente:

adb reverse tcp:8088 tcp:8088
 */