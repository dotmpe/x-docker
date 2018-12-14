FROM phusion/baseimage:0.10.0

ARG username=treebox

USER root

# Setup Python3/Jupyter and some kernels
RUN \
  apt-get update -qq && \
  apt-get install -qqy \
  bzip2 wget build-essential \
  python3-dev python3-pip unzip libzmq3-dev \
  libssl-dev

# USER $username

RUN \
# Update for older dists
  pip3 install -vU setuptools && \
  pip3 install jupyter && \
  pip3 install bash_kernel gnuplot_kernel metakernel_bash redis_kernel ansible-kernel && \
  python3 -m bash_kernel.install && \
  python3 -m metakernel_bash install && \
  python3 -m gnuplot_kernel install && \
  python3 -m redis_kernel install && \
  python3 -m ansible_kernel.install

#RUN \
#  export USER=root && \
#  ls -la /root /root/.npm && \
#  chown -R root:root /root/.npm && \
#  npm install -g jp-coffeescript

# Install SBCL
RUN \
  wget -nv http://downloads.sourceforge.net/project/sbcl/sbcl/1.4.14/sbcl-1.4.14-x86-64-linux-binary.tar.bz2 && \
  bzip2 -cd sbcl-1.4.14-x86-64-linux-binary.tar.bz2 | tar xvf - && \
  cd sbcl-1.4.14-x86-64-linux && sh install.sh

# Setup Quicklisp and rc for root and user
RUN \
  wget -nv https://beta.quicklisp.org/quicklisp.lisp && \
  sbcl --load quicklisp.lisp --non-interactive --eval "(quicklisp-quickstart:install)" && \
\
  echo '#-quicklisp' >> /root/.sbclrc && \
  echo '(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"' >> /root/.sbclrc && \
  echo '                                       (user-homedir-pathname))))' >> /root/.sbclrc && \
  echo '  (when (probe-file quicklisp-init)' >> /root/.sbclrc && \
  echo '    (load quicklisp-init)))' >> /root/.sbclrc && \
  echo '(push #p"/workspace/" asdf:*central-registry*)' >> /root/.sbclrc

# Setup cl-jupyter kernel
RUN \
  wget -nv https://github.com/fredokun/cl-jupyter/archive/master.zip && \
  unzip master.zip && \
  python3 ./cl-jupyter-master/install-cl-jupyter.py && \
  sbcl --load ./cl-jupyter-master/cl-jupyter.lisp --non-interactive

# TODO: Setup nodejs kernel
#RUN \
#  mkdir -v /src/github.com/notablemind && \
#  cd /src/github.com/notablemind && \
#  git clone https://github.com/notablemind/jupyter-nodejs.git && \
#  cd jupyter-nodejs && \
#  mkdir -p ~/.ipython/kernels/nodejs/ && \
#  npm install && node install.js && \
#  npm run build && \
#  npm run build-ext
#
#  # jupyter console --kernel nodejs

WORKDIR /notebooks
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"]
