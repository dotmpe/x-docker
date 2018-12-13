#FROM bvberkum/treebox:dev
#FROM phusion/baseimage:0.10.0

ARG X_DCKR_BASE=bvberkum/treebox
ARG X_DCKR_TAG=dev
FROM $X_DCKR_BASE:X_DCKR_TAG

RUN apt-get update -qq && apt-get install -y bzip2 wget build-essential python3-dev python3-pip unzip libzmq3-dev

RUN \
  wget -nv http://downloads.sourceforge.net/project/sbcl/sbcl/1.4.14/sbcl-1.4.14-x86-64-linux-binary.tar.bz2 && \
  wget -nv https://beta.quicklisp.org/quicklisp.lisp && \
  wget -nv https://github.com/fredokun/cl-jupyter/archive/master.zip
  
RUN bzip2 -cd sbcl-1.4.14-x86-64-linux-binary.tar.bz2 | tar xvf -

RUN unzip master.zip && cd sbcl-1.4.14-x86-64-linux && sh install.sh

# Update for older dists
RUN \
  pip3 install -vU setuptools && \
  pip3 install jupyter

RUN sbcl --load quicklisp.lisp --non-interactive --eval "(quicklisp-quickstart:install)"

RUN \
  echo '#-quicklisp' >> /root/.sbclrc && \
  echo '(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"' >> /root/.sbclrc && \
  echo '                                       (user-homedir-pathname))))' >> /root/.sbclrc && \
  echo '  (when (probe-file quicklisp-init)' >> /root/.sbclrc && \
  echo '    (load quicklisp-init)))' >> /root/.sbclrc && \
  echo '(push #p"/workspace/" asdf:*central-registry*)' >> /root/.sbclrc

RUN cp /root/.sbclrc /home/$username/ && \
  chown $username:$username /home/$username/.sbclrc

RUN python3 ./cl-jupyter-master/install-cl-jupyter.py
RUN sbcl --load ./cl-jupyter-master/cl-jupyter.lisp --non-interactive

WORKDIR /notebooks
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]
