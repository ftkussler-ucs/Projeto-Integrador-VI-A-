import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';

void main() {
  runApp(const AplicativoBrickBreaker());
}

// ============================================================
// PALETAS
// ============================================================

enum PaletaTijolos {
  classico,
  neon,
  pastel,
  retro,
}

// ============================================================
// APLICATIVO
// ============================================================

class AplicativoBrickBreaker extends StatelessWidget {
  const AplicativoBrickBreaker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brick Breaker',
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}

// ============================================================
// TELA INICIAL
// ============================================================

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  PaletaTijolos? paletaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // ==================================================
            // CONTEÚDO CENTRAL DA TELA
            // ==================================================

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // LOGO
                  const LogoBrickBreaker(),

                  const SizedBox(height: 18),

                  // TÍTULO
                  const Text(
                    'BRICK BREAKER',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // SUBTÍTULO
                  const Text(
                    'Clássico Breakout - UCS',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // BOTÃO INICIAR
                  BotaoMenu(
                    texto: 'INICIAR JOGO',
                    aoPressionar: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TelaJogo(
                            paleta: paletaSelecionada,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  // BOTÃO INTEGRANTES
                  BotaoMenu(
                    texto: 'INTEGRANTES',
                    aoPressionar: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TelaIntegrantes(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  // BOTÃO CONFIGURAÇÕES
                  BotaoMenu(
                    texto: 'CONFIGURAÇÕES',
                    aoPressionar: () async {
                      final resultado =
                          await Navigator.push<PaletaTijolos?>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TelaConfiguracoes(
                            paletaAtual: paletaSelecionada,
                          ),
                        ),
                      );

                      if (resultado != null) {
                        setState(() {
                          paletaSelecionada = resultado;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            // ==================================================
            // RODAPÉ
            // FICA CENTRALIZADO NA PARTE INFERIOR
            // ==================================================

            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Text(
                'Versão 1.0.0 Projeto Integrador VI-A',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// LOGO
// ============================================================

class LogoBrickBreaker extends StatelessWidget {
  const LogoBrickBreaker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (linha) => Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (coluna) => Container(
              width: 28,
              height: 12,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// BOTÃO DO MENU
// ============================================================

class BotaoMenu extends StatefulWidget {
  final String texto;
  final VoidCallback aoPressionar;

  const BotaoMenu({
    super.key,
    required this.texto,
    required this.aoPressionar,
  });

  @override
  State<BotaoMenu> createState() => _BotaoMenuState();
}

class _BotaoMenuState extends State<BotaoMenu> {
  bool pressionado = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          pressionado = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          pressionado = false;
        });

        widget.aoPressionar();
      },
      onTapCancel: () {
        setState(() {
          pressionado = false;
        });
      },
      child: Container(
        width: 230,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: pressionado ? Colors.black : Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          widget.texto,
          style: TextStyle(
            color: pressionado ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// TELA DE INTEGRANTES
// ============================================================

class TelaIntegrantes extends StatelessWidget {
  const TelaIntegrantes({super.key});

  final List<Integrante> integrantes = const [
    Integrante(
      nome: 'ANDERSON',
      sobrenome: 'VANZETTO',
      iniciais: 'AV',
    ),
    Integrante(
      nome: 'EMILLY',
      sobrenome: 'CORCETE',
      iniciais: 'EC',
    ),
    Integrante(
      nome: 'FRANCIELE',
      sobrenome: 'TERNES KUSSLER',
      iniciais: 'FK',
    ),
    Integrante(
      nome: 'MONIQUE',
      sobrenome: 'CRISTINA LEÃO ALVES',
      iniciais: 'MA',
    ),
    Integrante(
      nome: 'LUCCAS',
      sobrenome: 'FAGUNDES DE SOUZA',
      iniciais: 'LS',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Integrantes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: integrantes.length,
                itemBuilder: (context, index) {
                  final integrante = integrantes[index];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  const Color(0xFFE0E0E0),
                              child: Text(
                                integrante.iniciais,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${integrante.nome} ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        integrante.sobrenome,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (index != integrantes.length - 1)
                        Container(
                          height: 1,
                          color: Colors.grey.shade300,
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Integrante {
  final String nome;
  final String sobrenome;
  final String iniciais;

  const Integrante({
    required this.nome,
    required this.sobrenome,
    required this.iniciais,
  });
}

// ============================================================
// TELA DE CONFIGURAÇÕES
// ============================================================

class TelaConfiguracoes extends StatefulWidget {
  final PaletaTijolos? paletaAtual;

  const TelaConfiguracoes({
    super.key,
    this.paletaAtual,
  });

  @override
  State<TelaConfiguracoes> createState() =>
      _TelaConfiguracoesState();
}

class _TelaConfiguracoesState
    extends State<TelaConfiguracoes> {
  PaletaTijolos? paletaSelecionada;

  @override
  void initState() {
    super.initState();
    paletaSelecionada = widget.paletaAtual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (paletaSelecionada != null) {
                        Navigator.pop(
                          context,
                          paletaSelecionada,
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Configurações',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'COR DOS TIJOLOS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Escolha a paleta usada na parede do jogo',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.15,
                      children: [
                        CartaoPaleta(
                          nome: 'Clássico',
                          paleta: PaletaTijolos.classico,
                          selecionado:
                              paletaSelecionada ==
                                  PaletaTijolos.classico,
                          cores: const [
                            Colors.black,
                            Color(0xFF333333),
                            Color(0xFF555555),
                            Color(0xFF777777),
                          ],
                          aoSelecionar: () {
                            setState(() {
                              paletaSelecionada =
                                  PaletaTijolos.classico;
                            });
                          },
                        ),
                        CartaoPaleta(
                          nome: 'Neon',
                          paleta: PaletaTijolos.neon,
                          selecionado:
                              paletaSelecionada ==
                                  PaletaTijolos.neon,
                          cores: const [
                            Colors.pink,
                            Colors.cyan,
                            Colors.greenAccent,
                            Colors.yellow,
                          ],
                          aoSelecionar: () {
                            setState(() {
                              paletaSelecionada =
                                  PaletaTijolos.neon;
                            });
                          },
                        ),
                        CartaoPaleta(
                          nome: 'Pastel',
                          paleta: PaletaTijolos.pastel,
                          selecionado:
                              paletaSelecionada ==
                                  PaletaTijolos.pastel,
                          cores: const [
                            Color(0xFFFFB6C1),
                            Color(0xFFADD8E6),
                            Color(0xFFFFE4A1),
                            Color(0xFFC8E6C9),
                          ],
                          aoSelecionar: () {
                            setState(() {
                              paletaSelecionada =
                                  PaletaTijolos.pastel;
                            });
                          },
                        ),
                        CartaoPaleta(
                          nome: 'Retrô',
                          paleta: PaletaTijolos.retro,
                          selecionado:
                              paletaSelecionada ==
                                  PaletaTijolos.retro,
                          cores: const [
                            Color(0xFFD2691E),
                            Color(0xFF8B4513),
                            Color(0xFFFFD700),
                            Color(0xFF4682B4),
                          ],
                          aoSelecionar: () {
                            setState(() {
                              paletaSelecionada =
                                  PaletaTijolos.retro;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Se nenhuma paleta for escolhida, os tijolos '
                      'serão exibidos em cinza-claro.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CARTÃO DA PALETA
// ============================================================

class CartaoPaleta extends StatelessWidget {
  final String nome;
  final PaletaTijolos paleta;
  final bool selecionado;
  final List<Color> cores;
  final VoidCallback aoSelecionar;

  const CartaoPaleta({
    super.key,
    required this.nome,
    required this.paleta,
    required this.selecionado,
    required this.cores,
    required this.aoSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: aoSelecionar,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: selecionado ? 2.5 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: cores
                      .map(
                        (cor) => Container(
                          width: 25,
                          height: 12,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                          decoration: BoxDecoration(
                            color: cor,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.circular(2),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 15),
                Text(
                  nome,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if (selecionado)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TELA DO JOGO
// ============================================================

class TelaJogo extends StatefulWidget {
  final PaletaTijolos? paleta;

  const TelaJogo({
    super.key,
    this.paleta,
  });

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  late JogoBrickBreaker jogo;

  @override
  void initState() {
    super.initState();

    jogo = JogoBrickBreaker(
      paleta: widget.paleta,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<JogoBrickBreaker>(
        game: jogo,
        overlayBuilderMap: {
          'hud': (context, jogo) {
            return HudJogo(
              jogo: jogo,
              aoVoltarInicio: () {
                Navigator.of(context).popUntil(
                  (rota) => rota.isFirst,
                );
              },
            );
          },
          'bolaPerdida': (context, jogo) {
            return TelaBolaPerdida(
              jogo: jogo,
              aoVoltarInicio: () {
                Navigator.of(context).popUntil(
                  (rota) => rota.isFirst,
                );
              },
            );
          },
          'nivelConcluido': (context, jogo) {
            return TelaNivelConcluido(
              jogo: jogo,
              aoVoltarInicio: () {
                Navigator.of(context).popUntil(
                  (rota) => rota.isFirst,
                );
              },
            );
          },
        },
        initialActiveOverlays: const [
          'hud',
        ],
      ),
    );
  }
}

// ============================================================
// JOGO
// ============================================================

class JogoBrickBreaker extends FlameGame {
  final PaletaTijolos? paleta;

  JogoBrickBreaker({
    this.paleta,
  });

  int nivelAtual = 1;
  int pontuacao = 0;

  bool partidaIniciada = false;
  bool bolaPerdida = false;
  bool nivelConcluido = false;

  Bola? bola;
  Plataforma? plataforma;

  final List<Tijolo> tijolos = [];

  final List<List<int>> niveis = [
    [
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
      1, 1, 1, 1, 1, 1, 1, 1,
    ],
    [
      1, 1, 0, 1, 0, 0, 1, 1,
      0, 0, 1, 1, 1, 0, 1, 0,
      1, 1, 1, 0, 1, 1, 0, 1,
      0, 1, 0, 1, 0, 1, 1, 1,
      1, 1, 1, 1, 0, 1, 1, 0,
    ],
    [
      0, 0, 0, 1, 1, 0, 0, 0,
      0, 0, 1, 1, 1, 1, 0, 0,
      0, 1, 1, 1, 1, 1, 1, 0,
      1, 1, 1, 1, 1, 1, 1, 1,
      0, 0, 0, 1, 1, 0, 0, 0,
    ],
    [
      0, 0, 0, 0, 0, 0, 0, 1,
      0, 0, 0, 0, 0, 0, 1, 1,
      0, 0, 0, 0, 0, 1, 1, 1,
      0, 0, 0, 0, 1, 1, 1, 1,
      0, 0, 0, 1, 1, 1, 1, 1,
    ],
    [
      0, 0, 0, 1, 1, 0, 0, 0,
      0, 0, 1, 1, 2, 2, 1, 0,
      0, 1, 1, 1, 2, 2, 1, 1,
      0, 0, 1, 1, 2, 2, 1, 0,
      0, 0, 0, 1, 1, 0, 0, 0,
    ],
  ];

  @override
  Color backgroundColor() {
    if (bolaPerdida || nivelConcluido) {
      return const Color(0xFFE0E0E0);
    }

    return Colors.white;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    carregarNivel();

    overlays.add('hud');
  }

  // ==========================================================
  // CARREGAR NÍVEL
  // ==========================================================

  void carregarNivel() {
    bolaPerdida = false;
    nivelConcluido = false;
    partidaIniciada = false;

    overlays.remove('bolaPerdida');
    overlays.remove('nivelConcluido');

    removeAll(children.toList());

    tijolos.clear();

    final larguraTela = size.x;

    plataforma = Plataforma(
      position: Vector2(
        larguraTela / 2 - 50,
        size.y - 80,
      ),
      size: Vector2(100, 14),
    );

    add(plataforma!);

    bola = Bola(
      position: Vector2(
        larguraTela / 2 - 8,
        size.y - 105,
      ),
      radius: 8,
    );

    add(bola!);

    add(
      LinhaPontilhada(
        y: 105,
        largura: larguraTela,
      ),
    );

    const int colunas = 8;
    const int linhas = 5;

    const double espacamento = 4;
    const double margem = 15;

    final double larguraTijolo =
        (larguraTela -
                (margem * 2) -
                ((colunas - 1) * espacamento)) /
            colunas;

    const double alturaTijolo = 22;

    final nivel = niveis[nivelAtual - 1];

    for (int linha = 0; linha < linhas; linha++) {
      for (int coluna = 0;
          coluna < colunas;
          coluna++) {
        final indice = linha * colunas + coluna;
        final tipo = nivel[indice];

        if (tipo == 0) {
          continue;
        }

        final bool resistente = tipo == 2;

        final double x = margem +
            coluna * (larguraTijolo + espacamento);

        final double y =
            125 + linha * (alturaTijolo + espacamento);

        final tijolo = Tijolo(
          posicao: Vector2(x, y),
          tamanho: Vector2(
            larguraTijolo,
            alturaTijolo,
          ),
          resistente: resistente,
          cor: corDoTijolo(linha),
        );

        tijolos.add(tijolo);

        add(tijolo);
      }
    }
  }

  // ==========================================================
  // COR DOS TIJOLOS
  // ==========================================================

  Color corDoTijolo(int linha) {
    // Nenhuma paleta escolhida:
    // todos os tijolos ficam cinza-claro.
    if (paleta == null) {
      return const Color(0xFFE0E0E0);
    }

    switch (paleta!) {
      case PaletaTijolos.classico:
        const cores = [
          Color(0xFF222222),
          Color(0xFF444444),
          Color(0xFF666666),
          Color(0xFF888888),
          Color(0xFFAAAAAA),
        ];

        return cores[linha % cores.length];

      case PaletaTijolos.neon:
        const cores = [
          Colors.pink,
          Colors.cyan,
          Colors.greenAccent,
          Colors.yellow,
          Colors.purpleAccent,
        ];

        return cores[linha % cores.length];

      case PaletaTijolos.pastel:
        const cores = [
          Color(0xFFFFB6C1),
          Color(0xFFADD8E6),
          Color(0xFFFFE4A1),
          Color(0xFFC8E6C9),
          Color(0xFFD1C4E9),
        ];

        return cores[linha % cores.length];

      case PaletaTijolos.retro:
        const cores = [
          Color(0xFFD2691E),
          Color(0xFF8B4513),
          Color(0xFFFFD700),
          Color(0xFF4682B4),
          Color(0xFFCD5C5C),
        ];

        return cores[linha % cores.length];
    }
  }

  // ==========================================================
  // INICIAR PARTIDA
  // ==========================================================

  void iniciarPartida(double direcao) {
    if (partidaIniciada) {
      return;
    }

    partidaIniciada = true;

    if (direcao >= 0) {
      bola?.velocidade =
          Vector2(180, -180);
    } else {
      bola?.velocidade =
          Vector2(-180, -180);
    }
  }

  // ==========================================================
  // VERIFICAR FIM DO NÍVEL
  // ==========================================================

  void verificarFimNivel() {
    if (tijolos.isEmpty) {
      nivelConcluido = true;

      overlays.add('nivelConcluido');
    }
  }

  // ==========================================================
  // PRÓXIMO NÍVEL
  // ==========================================================

  void proximoNivel() {
    if (nivelAtual < 5) {
      nivelAtual++;

      carregarNivel();
    }
  }

  // ==========================================================
  // RECOMEÇAR
  // ==========================================================

  void recomecarNivel() {
    carregarNivel();
  }

  // ==========================================================
  // BOLA PERDIDA
  // ==========================================================

  void perderBola() {
    if (bolaPerdida) {
      return;
    }

    bolaPerdida = true;
    partidaIniciada = false;

    overlays.add('bolaPerdida');
  }
}

// ============================================================
// BOLA
// ============================================================

class Bola extends CircleComponent
    with HasGameReference<JogoBrickBreaker> {
  Vector2 velocidade = Vector2.zero();

  Bola({
    required Vector2 position,
    required double radius,
  }) : super(
          position: position,
          radius: radius,
          paint: Paint()
            ..color = Colors.black,
        );

  @override
  void update(double dt) {
    super.update(dt);

    if (!game.partidaIniciada ||
        game.bolaPerdida ||
        game.nivelConcluido) {
      return;
    }

    position += velocidade * dt;

    verificarParede();
    verificarPlataforma();
    verificarTijolos();

    if (position.y > game.size.y) {
      game.perderBola();
    }
  }

  // ==========================================================
  // PAREDES
  // ==========================================================

  void verificarParede() {
    if (position.x <= 0) {
      position.x = 0;
      velocidade.x = velocidade.x.abs();
    }

    if (position.x + radius * 2 >= game.size.x) {
      position.x =
          game.size.x - radius * 2;

      velocidade.x =
          -velocidade.x.abs();
    }

    if (position.y <= 105) {
      position.y = 105;
      velocidade.y =
          velocidade.y.abs();
    }
  }

  // ==========================================================
  // PLATAFORMA
  // ==========================================================

  void verificarPlataforma() {
    final plataforma = game.plataforma;

    if (plataforma == null) {
      return;
    }

    final bolaEsquerda = position.x;
    final bolaDireita =
        position.x + radius * 2;
    final bolaBaixo =
        position.y + radius * 2;

    final plataformaEsquerda =
        plataforma.position.x;

    final plataformaDireita =
        plataforma.position.x +
            plataforma.size.x;

    final plataformaTopo =
        plataforma.position.y;

    if (bolaDireita >= plataformaEsquerda &&
        bolaEsquerda <= plataformaDireita &&
        bolaBaixo >= plataformaTopo &&
        velocidade.y > 0) {
      position.y =
          plataformaTopo - radius * 2;

      velocidade.y =
          -velocidade.y.abs();

      final centroPlataforma =
          plataforma.position.x +
              plataforma.size.x / 2;

      final centroBola =
          position.x + radius;

      final diferenca =
          (centroBola -
                  centroPlataforma) /
              50;

      velocidade.x =
          diferenca * 180;
    }
  }

  // ==========================================================
  // TIJOLOS
  // ==========================================================

  void verificarTijolos() {
    for (final tijolo
        in List<Tijolo>.from(game.tijolos)) {
      if (!tijolo.isMounted) {
        continue;
      }

      final bolaEsquerda = position.x;
      final bolaDireita =
          position.x + radius * 2;

      final bolaTopo = position.y;
      final bolaBaixo =
          position.y + radius * 2;

      final tijoloEsquerda =
          tijolo.position.x;

      final tijoloDireita =
          tijolo.position.x +
              tijolo.size.x;

      final tijoloTopo =
          tijolo.position.y;

      final tijoloBaixo =
          tijolo.position.y +
              tijolo.size.y;

      final colidiu =
          bolaDireita >= tijoloEsquerda &&
          bolaEsquerda <= tijoloDireita &&
          bolaBaixo >= tijoloTopo &&
          bolaTopo <= tijoloBaixo;

      if (colidiu) {
        velocidade.y = -velocidade.y;

        tijolo.receberAcerto();

        break;
      }
    }
  }
}

// ============================================================
// TIJOLO
// ============================================================

class Tijolo extends RectangleComponent
    with HasGameReference<JogoBrickBreaker> {
  int vida;

  final bool resistente;

  Tijolo({
    required Vector2 posicao,
    required Vector2 tamanho,
    required this.resistente,
    required Color cor,
  })  : vida = resistente ? 2 : 1,
        super(
          position: posicao,
          size: tamanho,
          paint: Paint()
            ..color = resistente
                ? const Color(0xFF999999)
                : cor,
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final borda = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRect(
      size.toRect(),
      borda,
    );
  }

  void receberAcerto() {
    vida--;

    if (vida <= 0) {
      game.tijolos.remove(this);

      removeFromParent();

      game.pontuacao +=
          resistente ? 20 : 10;

      game.verificarFimNivel();
    } else {
      paint.color =
          const Color(0xFFCCCCCC);
    }
  }
}

// ============================================================
// PLATAFORMA
// ============================================================

class Plataforma extends RectangleComponent
    with DragCallbacks,
        HasGameReference<JogoBrickBreaker> {
  Plataforma({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
          paint: Paint()
            ..color = Colors.black,
        );

  @override
  void onDragUpdate(
      DragUpdateEvent evento) {
    position.x +=
        evento.localDelta.x;

    if (position.x < 0) {
      position.x = 0;
    }

    if (position.x + size.x >
        game.size.x) {
      position.x =
          game.size.x - size.x;
    }

    if (!game.partidaIniciada) {
      game.iniciarPartida(
        evento.localDelta.x,
      );
    }
  }
}

// ============================================================
// LINHA PONTILHADA
// ============================================================

class LinhaPontilhada
    extends PositionComponent {
  final double largura;

  LinhaPontilhada({
    required double y,
    required this.largura,
  }) : super(
          position: Vector2(0, y),
          size: Vector2(largura, 1),
        );

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    const tamanhoPonto = 4.0;
    const espaco = 6.0;

    double x = 0;

    while (x < largura) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(
          x + tamanhoPonto,
          0,
        ),
        paint,
      );

      x += tamanhoPonto + espaco;
    }
  }
}

// ============================================================
// HUD DO JOGO
// ============================================================

class HudJogo extends StatelessWidget {
  final JogoBrickBreaker jogo;
  final VoidCallback aoVoltarInicio;

  const HudJogo({
    super.key,
    required this.jogo,
    required this.aoVoltarInicio,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: Row(
          children: [
            Text(
              'NÍVEL ${jogo.nivelAtual}/5',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const Spacer(),

            Text(
              'PONTOS: ${jogo.pontuacao}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const Spacer(),

            GestureDetector(
              onTap: aoVoltarInicio,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius:
                      BorderRadius.circular(5),
                ),
                child: const Text(
                  'VOLTAR',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TELA BOLA PERDIDA
// ============================================================

class TelaBolaPerdida extends StatelessWidget {
  final JogoBrickBreaker jogo;
  final VoidCallback aoVoltarInicio;

  const TelaBolaPerdida({
    super.key,
    required this.jogo,
    required this.aoVoltarInicio,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius:
              BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'BOLA PERDIDA',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'PONTOS: ${jogo.pontuacao}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 25),

            BotaoOverlay(
              texto: 'RECOMEÇAR NÍVEL',
              aoPressionar: () {
                jogo.recomecarNivel();
              },
            ),

            const SizedBox(height: 10),

            if (jogo.nivelAtual < 5)
              BotaoOverlay(
                texto: 'PRÓXIMO NÍVEL',
                aoPressionar: () {
                  jogo.proximoNivel();
                },
              ),

            const SizedBox(height: 10),

            BotaoOverlay(
              texto: 'TELA INICIAL',
              aoPressionar: aoVoltarInicio,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TELA NÍVEL CONCLUÍDO
// ============================================================

class TelaNivelConcluido
    extends StatelessWidget {
  final JogoBrickBreaker jogo;
  final VoidCallback aoVoltarInicio;

  const TelaNivelConcluido({
    super.key,
    required this.jogo,
    required this.aoVoltarInicio,
  });

  @override
  Widget build(BuildContext context) {
    final bool ultimoNivel =
        jogo.nivelAtual == 5;

    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          borderRadius:
              BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ultimoNivel
                  ? 'JOGO CONCLUÍDO!'
                  : 'NÍVEL ${jogo.nivelAtual} CONCLUÍDO!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'PONTOS: ${jogo.pontuacao}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 25),

            if (!ultimoNivel)
              BotaoOverlay(
                texto: 'PRÓXIMO NÍVEL',
                aoPressionar: () {
                  jogo.proximoNivel();
                },
              ),

            if (ultimoNivel)
              BotaoOverlay(
                texto: 'JOGAR NOVAMENTE',
                aoPressionar: () {
                  jogo.nivelAtual = 1;
                  jogo.pontuacao = 0;
                  jogo.carregarNivel();
                },
              ),

            const SizedBox(height: 10),

            BotaoOverlay(
              texto: 'TELA INICIAL',
              aoPressionar: aoVoltarInicio,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BOTÃO DOS AVISOS
// ============================================================

class BotaoOverlay extends StatelessWidget {
  final String texto;
  final VoidCallback aoPressionar;

  const BotaoOverlay({
    super.key,
    required this.texto,
    required this.aoPressionar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        onPressed: aoPressionar,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5),
          ),
        ),
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}