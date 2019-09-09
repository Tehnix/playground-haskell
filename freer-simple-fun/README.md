# Conditioner - Playing with Effects

The repository is an exploration of using extensible effects, specifically via the [freer-simple](http://hackage.haskell.org/package/freer-simple) library.

To make it a state of the art, modern Haskell project, we furthermore throw out the default Prelude, and use [relude](http://hackage.haskell.org/package/relude) instead, along with using [lenses](http://hackage.haskell.org/package/lens). Finally, we enable a bunch of Haskell extensions, project-wide, that are very useful.

## Getting Started

It is assumed that you already have [stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/) installed, else set it up first.

Building the project,

```bash
$ stack build
```

Running tests on file changes,

```bash
$ stack test --fast --file-watch
```

Developing with ghcid,

```bash
$ ghcid
```

## Resources

_General_:

- [An opinionated guide to Haskell in 2018](https://lexi-lambda.github.io/blog/2018/02/10/an-opinionated-guide-to-haskell-in-2018/)

_Relude_:

- [relude documentation](http://hackage.haskell.org/package/relude)

_Lenses_:

- [lenses documentation](http://hackage.haskell.org/package/lens)
- [Taking a closer look at lenses](https://mmhaskell.com/blog/2017/6/12/taking-a-close-look-at-lenses)
- [A Little Lense Starter Tutorial](https://www.schoolofhaskell.com/school/to-infinity-and-beyond/pick-of-the-week/a-little-lens-starter-tutorial)

_Extensible Effects_:

- [freer-simple documentation](http://hackage.haskell.org/package/freer-simple)
- ["Freer than Free" blog post on using freer-simple](http://shmish111.github.io/2018/09/23/freer-than-free/)
- [Sandy Maguire: Don't Eff It Up: Freer Monads in Action](https://www.youtube.com/watch?v=gUPuWHAt6SA&t=)
- [Eff to the Rescue!](https://mmhaskell.com/blog/2017/11/20/eff-to-the-rescue) (still relevant, even though it uses [freer-effects](https://hackage.haskell.org/package/freer-effects), which freer-simple is forked from)
- And there's of course always the original papers introducing them[[1]](http://okmij.org/ftp/Haskell/extensible/more.pdf)[[2]](http://okmij.org/ftp/Haskell/extensible/exteff.pdf), but while they give a deeper theoretical understanding, they add little value when it comes to usage in practice
