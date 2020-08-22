require_relative 'common'

def install_subtree(name, repo, path)
  system "git remote add -f #{name} #{repo}"
  if !File.exist?(path)
    system "git subtree add --prefix #{path} #{name} master --squash"
  end
end

def update_subtree(name, path)
  system %(git subtree pull --prefix #{path} #{name} master --squash)
end
