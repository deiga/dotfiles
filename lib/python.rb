require_relative 'common'

def install_python
    system 'brew install python'
    system 'curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python'
    update_python
end

def update_python
    system %(python -m pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 python -m pip install -U)
    system %{LIBGIT2="$HOME/local" LDFLAGS="-Wl,-rpath='$LIBGIT2/lib',--enable-new-dtags $LDFLAGS" python -m pip install -U pygit2} unless OSX
    system 'poetry self update'
end
