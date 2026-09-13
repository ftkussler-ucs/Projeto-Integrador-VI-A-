# Ambiente de Desenvolvimento, Tecnologias e Geração do APK

## Tecnologias e linguagens

- **Framework:** Flutter
- **Linguagem:** Dart
- **Motor de jogo:** Flame Engine
- **Controle de versão:** Git + GitHub

Escolhidos por ser a stack sugerida no enunciado do projeto, por permitir gerar o .apk a partir de um único código e por o Flame já resolver game loop, colisão e áudio, itens exigidos.

## Ambiente de desenvolvimento

- **IDE principal:** VS Code, com as extensões **Flutter** e **Dart**.
- **Android Studio:** usado só para o Android SDK Manager e o AVD Manager (criação de emulador).
- **Testes:** emulador Android, criado no AVD Manager e executado a partir do VS Code (hot reload).

### Instalação
1. Instalar o [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Instalar o [Android Studio](https://developer.android.com/studio) (para SDK e emulador).
3. Instalar o [VS Code](https://code.visualstudio.com/) com as extensões Flutter e Dart.
4. Rodar `flutter doctor` e conferir se está tudo ok.
5. Criar um emulador pelo AVD Manager.

## Como o APK será gerado
Projeto criado com:
```bash
flutter create brick_breaker
```

APK final gerado com:
```bash
flutter build apk --release
```

Arquivo gerado em:
```
build/app/outputs/flutter-apk/app-release.apk
```

