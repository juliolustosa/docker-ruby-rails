module Config
  class Gemfile
    def initialize(app_path='/app', rails_env='production', tmp_dir='/scripts/tmp')
      @rails_env = rails_env
      @gem_file = "#{app_path}/Gemfile"
      @tmp_gem_file = "#{tmp_dir}/Gemfile"
      # Create Temp Dir
      unless Dir.exist?(tmp_dir)
        Dir.mkdir(tmp_dir)
      end
    end

    # Check Gemfiles
    def check
      exists_temp_gemfiles
      gemfile_is_new
    end

    private

    # Exists temp files
    def exists_temp_gemfiles
      unless File.exist?(@tmp_gem_file)
        if File.exist?(@gem_file)
          bundle_install
        else
          puts 'Gemfile not found'
        end
      end
    end

    # Check if gemfile is new
    def gemfile_is_new
      if File.exist?(@gem_file)
        unless File.read(@gem_file) == File.read(@tmp_gem_file)
          bundle_install
        end
        unless File.read("#{@gem_file}.lock") == File.read("#{@tmp_gem_file}.lock")
          bundle_install
        end
      end
    end

    # Run Bundle install and copy gemfiles
    def bundle_install
      system('bundle install && rbenv rehash')
      if @rails_env.to_s == 'production'
        system('bundle exec rails assets:precompile')
      end
      system("cp #{@gem_file} #{@tmp_gem_file}")
      system("cp #{@gem_file}.lock #{@tmp_gem_file}.lock")
      puts 'Bundle Completed'
    end
  end
end