# Rake task to run the server

desc "Start the server."
task "server", [:port, :use_local_ip_address] do |t, args|
  default_port = "7770"
  host = "localhost"
  if args.use_local_ip_address
    require 'socket'

    host = UDPSocket.open {|s| s.connect("64.233.187.99", 1); s.addr.last}
  end

  port_arg = args.port
  port = port_arg ? port_arg : default_port

  puts "Start server: http://#{host}:#{port}/"
  start_server_cmd = "bundle exec shotgun --server=thin --host=#{host} config.ru -p #{port}"
  start_server_cmd += " & grunt"

  sh start_server_cmd
end