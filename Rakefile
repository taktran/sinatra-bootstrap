# Rake file to help with development
require 'fileutils'

Dir.glob('lib/tasks/*.rake').each { |r| import r }

#####################################################################
# Server
#####################################################################

desc "Start the server using the development Procfile."
task "server" do
  puts `cat Procfile_development`
  start_server_cmd = "foreman start -f Procfile_development"
  sh start_server_cmd
end

#####################################################################
# Testing
#####################################################################

require 'rspec/core/rake_task'
desc "Run specs"
task :spec do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ["--color"]
    t.pattern = './spec/**/*_spec.rb'
  end
end

namespace "spec" do
  desc "Run individual spec. Can also pass in a line number."
  task :run, :spec_file, :line_number do |_, args|
    run_spec_cmd =  if args.line_number.nil?
                      "bundle exec ruby -S rspec --color #{args.spec_file}"
                    else
                      "bundle exec ruby -S rspec --color -l #{args.line_number} #{args.spec_file}"
                    end
    sh run_spec_cmd
  end
end
