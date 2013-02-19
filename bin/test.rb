# server.rb
case ARGV[0]
when "start"
  STDOUT.puts "called start"
when "stop"
  STDOUT.puts "called stop"
when "restart"
  STDOUT.puts "called restart"
else
  STDOUT.puts <<-EOF
Please provide command name

Usage:
  server start
  server stop
  server restart
EOF
end
