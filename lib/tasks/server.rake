desc "Start the server."
task "server", [:port] do |t, args|
  require 'socket'

  default_port = "7775"
  host = "0.0.0.0"
  ip_host = UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}

  port_arg = args.port
  port = port_arg ? port_arg : default_port

  puts "Start server: http://#{host}:#{port}/ (or you could use http://#{ip_host}:#{port}/)"
  start_server_cmd = "bundle exec shotgun --server=thin --host=#{host} config.ru -p #{port}"

  sh start_server_cmd
end
