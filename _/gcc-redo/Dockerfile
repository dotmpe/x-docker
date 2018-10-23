# GCC is Debian with build-essential
FROM gcc:8

RUN git clone https://github.com/apenwarr/redo.git /tmp/redo && \
  cd /tmp/redo && ./redo test && ./redo install
