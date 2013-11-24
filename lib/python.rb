require_relative 'common'

def install_python
    if OSX
        system %{brew install python --with-brewed-openssl}
    else
        system %{cd ~/local/build; wget http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz; tar -zxf Python-2.7.5.tgz; cd Python-2.7.5; ./configure --prefix=$HOME/local && make -j 3 && make install}
        system %{cd ~/local/build; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | python }
        system %{cd ~/local/build; curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python }
        system %{cd ~/local/build; git clone git://github.com/libgit2/libgit2.git -b master; cd libgit2; git pull origin; mkdir build; cd build; cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/local && cmake --build . --target install}
    end
    update_python
end

def update_python
    system %{pip install -U setuptools pip}
    system %{pip install -U mercurial psutil}
    system %{LIBGIT2="$HOME/local" LDFLAGS="-Wl,-rpath='$LIBGIT2/lib',--enable-new-dtags $LDFLAGS" pip install -U pygit2} unless OSX
end
