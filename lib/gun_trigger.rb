require 'rye'                                                                                                                                             
require 'fileutils'


class GunTrigger

  PRODUCTION = {
    :project_name => 'bumptious-music',
    :location => 'bumptiousmusic.com',
    :ssh_port => '22',
    :ssh_user => 'ec2-user',
    :repository => "https://github.com/bikokid/bumptious-music.git",
    :remote_checkout_directory => '/usr/local/src/bumptious-music',
    :remote_release_directory => '/http/bumptious-music',
    :remote_codebase_directory => '/usr/local/src/bumptious-music',
    :public_folder_owner => 'nobody:nobody',
    :rails_root_owner => 'ec2-user:ec2-user',
    :music_folder => "public/music",
    :remote_music_folder => "/music",
    :db_file => "database.staging.yml",
    :ssh_key => '/Users/lemynshij/mcarrmicro.pem'
  }

  STAGING = {
    :location => 'noexist.com'
  }

  def initialize(machine)
    @machine = machine
  end

  def uname
    puts '+++Running uname'
    puts system('uname -a')
  end

  def deploy
    puts '+++ Deploying to ' + @machine[:location]
    #Rye::Cmd.add_command :
    release_date = Time.now.strftime("%Y%m%d%H%M%S")
    puts '+++ Creating folder ' + release_date
    checkout_code( @machine[:remote_checkout_directory], release_date )  
    run_bundler(release_date)
    run_migrations( release_date)
    link_to_current_codebase( release_date)
    set_permissions( release_date)
    restart_webserver
  end

  def set_permissions(release_date)
    system 'chown -R ' + @machine[:rails_root_owner] + ' ' + File.join(@machine[:remote_codebase_directory], release_date )
    system 'sudo chown -R ' + @machine[:public_folder_owner] + ' ' + File.join(@machine[:remote_codebase_directory], release_date, "public" )
    system 'chown -R ' + @machine[:rails_root_owner] + ' ' + File.join(@machine[:remote_codebase_directory], "current")
    system 'sudo chown -R ' + @machine[:public_folder_owner] + ' ' + File.join(@machine[:remote_codebase_directory], "current", "public" )
  end

  def run_migrations(release_date)
    system("mv " + File.join(@machine[:remote_codebase_directory], release_date, "config", @machine[:db_file]) + " " + File.join(@machine[:remote_codebase_directory], release_date, "config", 'database.yml') )
    system('rake ' +  "-f" + " "  + File.join(@machine[:remote_codebase_directory], release_date, "Rakefile") +  " db:migrate " + " RAILS_ENV=production")
  end

  def run_bundler(release_date)
    cmd = "cd " + File.join(@machine[:remote_codebase_directory], release_date) + "; " + 'bundle install --deployment'
    puts "+++ Running " + cmd
    puts system(cmd)
  end

  def link_to_current_codebase(release_date)
    puts "+++ Running rm -f " + File.join(@machine[:remote_codebase_directory], "current")
    system( 'rm -f ' +  File.join(@machine[:remote_codebase_directory] ,  "current"))
    puts "+++ Running ln -s " + File.join(@machine[:remote_codebase_directory], release_date) + " " +  File.join(@machine[:remote_codebase_directory], "current")
    system('ln -s ' + File.join(@machine[:remote_codebase_directory], release_date) + ' ' + File.join(@machine[:remote_codebase_directory], "current"))
    remote_music_dest_folder = File.join(@machine[:remote_codebase_directory], "current", @machine[:music_folder]) 
    puts "+++ Running rm -fr " + remote_music_dest_folder
    system('rm -fr ' + remote_music_dest_folder)
    puts "+++ Running ln -s " + @machine[:remote_music_folder] + " " + remote_music_dest_folder
    system('ln -s ' + @machine[:remote_music_folder] + ' ' + remote_music_dest_folder )
  end

  def restart_webserver
    system "sudo /usr/local/nginx/sbin/nginx -s reload"
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
    system "mkdir #{rlocation}/#{sfolder} "
    cmd = "cd " + rlocation + ";git clone --recursive " + @machine[:repository] + ' ' + sfolder
    puts "+++ Running " + cmd
    system(cmd)
  end

  def rollback
  end
end
