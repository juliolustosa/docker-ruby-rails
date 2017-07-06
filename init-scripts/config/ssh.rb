module Config
  class Ssh
    def initialize(user)
      user = 'root' if user.to_s.size == 0
      if user == 'root'
        @ssh_dir = "/#{user}/.ssh"
      else
        @ssh_dir = "/home/#{user}/.ssh"
      end
      # Create SSH Dir
      unless Dir.exist?(@ssh_dir)
        Dir.mkdir(@ssh_dir, 0755)
      end
    end

    # Install SSH Private Key
    def install_private_key(key, file='id_rsa')
      key_file = "#{@ssh_dir}/#{file}"
      unless File.exist?(key_file)
        File.open(key_file, 'w', 0600){ |f| f.write key }
        system("ssh-agent sh -c 'ssh-add #{key_file}'")
        puts 'Private Key Created'
      end
    end

    # Set known_hosts
    def set_known_hosts(hosts)
      known_hosts = "#{@ssh_dir}/known_hosts"
      File.open(known_hosts, 'w', 0644){ |f| f.write '' } unless File.exist?(known_hosts)
      hosts.to_s.strip.split(' ').each do |host|
        unless File.read("#{known_hosts}").include? host
          system("ssh-keyscan -t rsa #{host} >> #{known_hosts}")
          puts "Known Host Added: #{host}"
        end
      end
    end
  end
end