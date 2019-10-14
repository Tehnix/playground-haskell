# Fun with Polysemy

This is an exploration in the usage of Polysemy, the latest and greatest Freer effects library.


### Setting up an Environment

Inside the project:
```bash
$ stack build --copy-compiler-tool brittany
```

Somewhere, do:
```bash
$ git clone git@github.com:digital-asset/ghcide.git \
   && cd ghcide \
   && stack --stack-yaml stack88.yaml build --copy-compiler-tool
```

# Resources

- https://haskell-explained.gitlab.io/blog/posts/2019/07/28/polysemy-is-cool-part-1/index.html
- https://haskell-explained.gitlab.io/blog/posts/2019/07/31/polysemy-is-cool-part-2/index.html
- https://github.com/polysemy-research/polysemy
