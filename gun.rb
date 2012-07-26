#!/usr/local/bin/ruby

require 'trollop'
require 'rye'
require 'fileutils'

STAGING = {
  :project_name => 'bumptious',
  :location => 'bumptious.com',
  :ssh_port => '2222',
  :ssh_user => 'root',
  :repository => "path/to/bumptious/repos",
  :local_checkout_directory => '/rootusr/tmp',
  :remote_release_directory => '/var/www/vhosts/bumptious.com/fc',
  :remote_codebase_directory => '/usr/local/src/bumptious',
  :public_folder_owner => 'test:psaserv',
  :rails_root_owner => 'test:psacln',
  :product_images_folder => "public/images/products",
  :remote_product_image_folder => "/var/www/vhosts/bumptious.com/httpdocs/images",
  :db_file => "database.staging.yml"
}

PRODUCTION = {
  :location => 'bumptious.com'
}

def uname
  puts 'Running uname'
  lbox = Rye::Box.new( @machine[:location], { :port => @machine[:ssh_port], :user => @machine[:ssh_user]} )
  puts lbox.uname(:a)
end

def deploy
  puts '+++ Deploying to ' + @machine[:location]
  #Rye::Cmd.add_command :
  lbox = Rye::Box.new( @machine[:location], { :port => @machine[:ssh_port], :user => @machine[:ssh_user]} )
  release_date = Time.now.strftime("%Y%m%d%H%M%S")
  puts '+++ Creating folder ' + release_date
  checkout_code( @machine[:local_checkout_directory], release_date )  
  puts "+++ Running copy"
  copy_code( lbox, release_date )
  #do mysql related stuff here
  run_bundler(lbox, release_date)
  run_migrations(lbox, release_date)
  link_to_current_codebase(lbox, release_date)
  set_permissions(lbox, release_date)
  restart_webserver(lbox)
end

def set_permissions(box, release_date)
  box.chown "-R", @machine[:rails_root_owner], File.join(@machine[:remote_codebase_directory], release_date )
  box.chown "-R", @machine[:public_folder_owner], File.join(@machine[:remote_codebase_directory], release_date, "public" )
  box.chown "-R", @machine[:rails_root_owner], File.join(@machine[:remote_codebase_directory], "current")
  box.chown "-R", @machine[:public_folder_owner], File.join(@machine[:remote_codebase_directory], "current", "public" )
end

def run_migrations(box, release_date)
  puts box.mv File.join(@machine[:remote_codebase_directory], release_date, "config", @machine[:db_file]), File.join(@machine[:remote_codebase_directory], release_date, "config", 'database.yml')
  puts box.rake "-f", File.join(@machine[:remote_codebase_directory], release_date, "Rakefile"),  "db:migrate", "RAILS_ENV=production"
end

def run_bundler(box, release_date)
  box.disable_safe_mode
  cmd = "cd " + File.join(@machine[:remote_codebase_directory], release_date) + "; " + 'bundle install'
  puts "+++ Running " + cmd
  puts box.execute cmd
  box.enable_safe_mode
end

def link_to_current_codebase(box, release_date)
  box.disable_safe_mode
  puts "+++ Running rm -f " + File.join(@machine[:remote_codebase_directory], "current")
  puts box.rm '-f', File.join(@machine[:remote_codebase_directory], "current")
  puts "+++ Running ln -s " + File.join(@machine[:remote_codebase_directory], release_date) + " " +  File.join(@machine[:remote_codebase_directory], "current")
  puts box.ln "-s", File.join(@machine[:remote_codebase_directory], release_date), File.join(@machine[:remote_codebase_directory], "current")
  remote_images_dest_folder = File.join(@machine[:remote_codebase_directory], "current", @machine[:product_images_folder]) 
  puts "+++ Running rm -fr " + remote_images_dest_folder
  puts box.rm '-fr', remote_images_dest_folder
  box.enable_safe_mode
  puts "+++ Running ln -s " + @machine[:remote_product_image_folder] + " " + remote_images_dest_folder
  puts box.ln "-s", @machine[:remote_product_image_folder], remote_images_dest_folder
end

def restart_webserver(box)
  box.disable_safe_mode
  puts box.execute "service httpd restart"
  box.enable_safe_mode
end

def copy_code( box, release_date )
  #tarball the code
  cmd = "cd " + @machine[:local_checkout_directory] + "; tar czvf " + @machine[:project_name] + ".tar.gz " + "./" + release_date 
  puts '+++ running ' + cmd
  system(cmd)
  #copy code
  puts '+++ running file upload ' + File.join(@machine[:local_checkout_directory], @machine[:project_name] + '.tar.gz') + ' to ' + File.join(@machine[:remote_codebase_directory], @machine[:project_name] + ".tar.gz")
  box.file_upload File.join(@machine[:local_checkout_directory], @machine[:project_name] + '.tar.gz'), File.join(@machine[:remote_codebase_directory], @machine[:project_name] + ".tar.gz")
  #unzip code
  puts "+++ running tar -xzv " + File.join(@machine[:remote_codebase_directory], @machine[:project_name] + '.tar.gz')
  #box.run_command "tar -xzvf " + File.join(@machine[:remote_codebase_directory], @machine[:project_name] + '.tar.gz')
  box.cd @machine[:remote_codebase_directory]
  puts box.tar "-xzvf", File.join(@machine[:remote_codebase_directory], @machine[:project_name] + '.tar.gz')
end

def checkout_code(rlocation, sfolder)
  FileUtils.mkdir( rlocation + '/' + sfolder )
  cmd = "cd " + rlocation + ";cvs checkout -d ./" + sfolder + " " + @machine[:repository]
  puts "+++ Running " + cmd
  system(cmd)
end

def rollback
end

## Here's a program called "gun". We want this behavior:
##
##   gun staging deploy => deploys code to staging
##   gun production deploy  => deploys to production
##
## 
##
## There are some global options, which appear to the left of the subcommand.
## There are some subcommand options, which appear to the right.
##
## Subcommand options can be specific to the subcommand. 'staging' might take
## different options from 'production'.
##
## We do this by calling Trollop twice; one for the global options and once for
## the subcommand options. We need to tell Trollop what the subcommands are, so
## that it stops processing the global options when it encounters one of them.

SUB_COMMANDS = %w(staging production)
global_opts = Trollop::options do
  banner "gun - simple trigger happy deployment"
  opt :dry_run, "Don't actually do anything", :short => "-n"
  opt :staging, "Run a command on staging", :short => "-s"
  opt :production, "Run a command on production", :short => "-p"
  stop_on SUB_COMMANDS
end

##These are the default settings
@machine = {
  :location => 'nolocationselected',
  :ssh_port => '22',
  :ssh_user => 'root'
  }

cmd = ARGV.shift # get the command
sub_cmd = ARGV.shift # get the subcommand
cmd_opts = case cmd
  when "staging" # parse delete options
    Trollop::options do
      opt :uname, "Check Kernel Version on staging server"
      opt :deploy, "Deploy to staging server"
    end
    @machine.merge!(STAGING)
  when "production"  # parse copy options
    Trollop::options do
      opt :deploy, "Deploy to production server"
    end
    @machine.merge!(PRODUCTION)
  else
    Trollop::die "unknown subcommand #{cmd.inspect}"
  end

sub_cmd_opts = case sub_cmd
  when "uname"
    uname
  when "deploy"
    deploy
  else
  end

#puts "Global options: #{global_opts.inspect}"
#puts "Subcommand: #{cmd.inspect}"
#puts "Subcommand options: #{cmd_opts.inspect}"
#puts "Remaining arguments: #{ARGV.inspect}"

