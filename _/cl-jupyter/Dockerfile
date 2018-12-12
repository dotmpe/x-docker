FROM buildpack-deps:jessie

RUN apt-get update -qq && apt-get install -y bzip2 wget build-essential python3-dev python3-pip unzip libzmq3-dev

RUN wget -nv http://downloads.sourceforge.net/project/sbcl/sbcl/1.3.2/sbcl-1.3.2-x86-64-linux-binary.tar.bz2
RUN wget -nv https://beta.quicklisp.org/quicklisp.lisp
RUN wget -nv https://github.com/fredokun/cl-jupyter/archive/master.zip

RUN bzip2 -cd sbcl-1.3.2-x86-64-linux-binary.tar.bz2 | tar xvf -
RUN unzip master.zip

RUN cd sbcl-1.3.2-x86-64-linux && sh install.sh
RUN pip3 install jupyter

RUN sbcl --load quicklisp.lisp --non-interactive --eval "(quicklisp-quickstart:install)"
RUN echo '#-quicklisp' >> /root/.sbclrc
RUN echo '(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"' >> /root/.sbclrc
RUN echo '                                       (user-homedir-pathname))))' >> /root/.sbclrc
RUN echo '  (when (probe-file quicklisp-init)' >> /root/.sbclrc
RUN echo '    (load quicklisp-init)))' >> /root/.sbclrc
RUN echo '(push #p"/workspace/" asdf:*central-registry*)' >> /root/.sbclrc

RUN python3 ./cl-jupyter-master/install-cl-jupyter.py
RUN sbcl --load ./cl-jupyter-master/cl-jupyter.lisp --non-interactive

WORKDIR /notebooks
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]
