# haskell-mania
Implementação simplificada do jogo osu!mania. Projeto para a disciplina Paradigmas e Linguagens de Programação.

Clone o repositório

```bash
$ git clone https://github.com/lucasbrenner/haskell-mania.git
```
Entre no repositório

```bash
$ cd haskell-mania
```

### Como rodar o jogo em haskell

#### Pré-requisitos:

De antemão é interessante que você:
- Tenha acesso a um terminal UNIX.
- Tenha instalado o [haskell plataform](https://www.haskell.org/platform/linux.html).
- Tenha o binário do `cabal` pronto para rodar em sua máquina(por default a instalação do haskell traz consigo o `cabal`)
- Tenha um display de dimensões maiores ou iguais há 700 de altura e 700 de largura.

Primeiramente precisamos instalar o `cabal-install` que é executável responsável por instalar as dependências necessárias para que o jogo funcione.
Para instalar execute em seu terminal:
```bash
$ cabal update
$ cabal install Cabal cabal-install
```

Em seguida instalaremos a lib `gloss` do `cabal` utilizando:
```bash
$ cabal install gloss
```

Entre no diretório de haskell

```bash
$ cd haskell
```

Agora para rodar o jogo e instalar as dependências faltantes execute:
```bash
$ cabal run
```

Esse comando vai inicialmente instalar as dêndencias do arquivo [`haskell-mania.cabal`](https://github.com/lucasbrenner/haskell-mania/blob/main/haskell-mania.cabal). Em seguida ele vai executar o jogo, abrindo assim uma janela com interface gráfica.

### Como rodar o jogo em Prolog

#### Pré-requisitos:

De antemão é interessante que você:
- Tenha acesso a um terminal UNIX.
- Tenha instalado [prolog](https://www.swi-prolog.org/download/stable).
- Tenha um display de dimensões maiores ou iguais há 700 de altura e 900 de largura.

Entre no diretório de prolog

```bash
$ cd prolog
```

Compile e rode o jogo executando

```bash
$ swipl -s Main.pl
```

