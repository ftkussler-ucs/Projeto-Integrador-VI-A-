# Métodos de Construção da Parede de Blocos

Documentação de como e quais métodos são usados para montar a parede de blocos (tijolos) do jogo, em Dart, utilizando o Flame Engine.

## Classe do bloco

Representa cada tijolo individual da parede. Recebe a posição em que o bloco vai ficar na tela, o tamanho (altura e largura) e a cor.

```dart
class Bloco extends RectangleComponent {
  Bloco({
    required Vector2 posicao,
    required Vector2 tamanho,
    required Color cor,
  }) : super(
          position: posicao,
          size: tamanho,
          paint: Paint()..color = cor,
        );
}
```

## Construção da parede

Classe responsável por gerar todos os blocos da parede. Utiliza dois laços `for` aninhados: o primeiro controla as **linhas** e o segundo, as **colunas**. Assim, os blocos são criados automaticamente, um a um, até formar a parede completa.

```dart
class Parede extends Component {
  void criarParede() {
    final int linhas = 5;
    final int colunas = 8;

    final Vector2 tamanhoBloco = Vector2(80, 30);

    for (int linha = 0; linha < linhas; linha++) {
      for (int coluna = 0; coluna < colunas; coluna++) {
        final Vector2 posicao = Vector2(
          coluna * 85,
          linha * 35,
        );

        final bloco = Bloco(
          posicao: posicao,
          tamanho: tamanhoBloco,
          cor: Colors.blue,
        );

        add(bloco);
      }
    }
  }
}
```

### Como funciona
- `linhas` e `colunas` definem o tamanho da parede (quantas fileiras e quantos blocos por fileira).
- A posição de cada bloco é calculada multiplicando o índice da coluna/linha pelo espaçamento (`85` e `35`), garantindo que os blocos fiquem lado a lado sem sobrepor.
- Cada bloco criado é adicionado ao componente da parede com `add(bloco)`.

## Organização dos blocos

Cada bloco é um componente independente dentro da parede criada — ou seja, cada tijolo pode ser tratado (destruído, colidido, animado) separadamente dos demais, mesmo fazendo parte da mesma estrutura.

## Próximos passos
- Definir cores/padrões diferentes por nível.
- Adicionar lógica de destruição do bloco ao colidir com a bola.
- Variar a disposição da parede (linhas/colunas) para cada um dos 5 níveis do jogo.
