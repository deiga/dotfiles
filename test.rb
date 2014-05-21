require 'rake'

EXCLUDE_COMMON = %w[Rakefile README.md LICENSE TODO.md KeyRemap4MacBook bin box config ssh powerline tmp lib]
files = Dir['*'] - EXCLUDE_COMMON - Dir['*~'] - Dir['*.log']
files = Rake::FileList["*"].exclude("*.log").exclude("*~") - EXCLUDE_COMMON
mkdir_p(File.join(ENV['HOME'],'Library/Application Support'))
mkdir_p %w[~/local/bin ~/local/build]

bin_folder = Dir['bin'][0]
