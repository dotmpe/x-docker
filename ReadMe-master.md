Usage:
```
docker run -v DIR:/project \
		dotmpe/BASE-bats [ARGV | -- CMD [ -- CMD ]*]
```

Test project with files from `test` dir:
```
docker run -v $(pwd -P):/project dotmpe/BASE-bats ./test/
```

The main issue for flexible test nodes is getting specific dependencies, so the
entry-point allows both installing additiona packages, and/or executing several
script lines in sequence.

Besides `bash` and `bats`, aditional tools installed into the base image are
`jq`, `curl` and `ncurses` if needed for ``tput``.

### Dockerfile builds at hub.docker.com

- [Basebox](https://hub.docker.com/r/dotmpe/basebox) [docs](ReadMe-basebox.md)

  - [Devbox](https://hub.docker.com/r/dotmpe/devbox)
  - [Testbox](https://hub.docker.com/r/dotmpe/testbox) [docs](ReadMe-testbox.md)

    - [Treebox](https://hub.docker.com/r/dotmpe/treebox) Py/Node/PHP dev container and user setup [docs](ReadMe-treebox.md)

      - [Sandbox](https://hub.docker.com/r/dotmpe/sandbox) treebox docker-in-docker
      - [Sitefile](https://hub.docker.com/r/dotmpe/node-sitefile)

      - [CL-Jupyter](https://hub.docker.com/r/dotmpe/cl-jupyter) LISP, Bash, Python codebook editor [docs](ReadMe-cl-jupyter.md)

### Other tools

- [How-to run glances webserver and client docker](https://gist.github.com/dotmpe/526c19c6edcc434a654fa24ea1c7e7dd)
