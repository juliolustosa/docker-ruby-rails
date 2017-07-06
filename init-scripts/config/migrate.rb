module Config
  class Migrate
    def initialize(app_path='/app')
      @app_path = app_path
      @rakefile_exist = rakefile_exist
    end

    def db_create
      if @rakefile_exist
        puts 'rake db:create'
        system('rake db:create')
      end
    end

    def db_migrate
      if @rakefile_exist
        puts 'Rails Migrate'
        system('bundle exec rails db:migrate')
      end
    end

    private

    def rakefile_exist
      rake_files = ['rakefile', 'Rakefile', 'rakefile.rb', 'Rakefile.rb']
      rake_files.each do |file|
        return true if File.exist?("#{@app_path}/#{file}")
      end
      false
    end
  end
end