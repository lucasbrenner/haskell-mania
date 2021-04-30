# haskell-mania
Implementação simplificada, em haskell, do jogo osu!mania. Projeto para a disciplina Paradigmas e Linguagens de Programação. A especificação pode ser acessada [aqui](https://docs.google.com/document/d/1lwtagUiFO9Q02JBbwOYXgF-W4obM0LcYw6z6qNljZ18/edit)

### Como rodar o jogo

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

Em seguida instalaremos a lib `gloss` do `caba` utilizando:
```bash
$ cabal install gloss
```

Agora para rodar o jogo e instalar as dependências faltantes execute:
```bash
$ cabal run
```
Esse comando vai inicialmente instalar as dêndencias do arquivo [`haskell-mania.cabal`](https://github.com/lucasbrenner/haskell-mania/blob/main/haskell-mania.cabal). Em seguida ele vai executar o jogo, abrindo assim uma janela com interface gráfica.
