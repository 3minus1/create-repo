require 'io/console'
require 'pathname'
module CreateRepo
  class Github
    def initialize
      setup  
    end

    def setup
      puts "Github Username: "
      @username = STDIN.gets.chomp
      puts "Github Password: "
      @password = STDIN.noecho(&:gets).chomp
    end

    def login
      puts "Logging in..."
      begin
        @client = Octokit::Client.new \
          :login    => "#{@username}",
          :password => "#{@password}" ; nil
        user = @client.user
        user.login 
      rescue
        puts `echo "\033[1;31mLogin failed! Try again\033[0m"`
        setup
        login
      end
    end

    def get_repo_info
      puts "Repository Name: (default: #{cwd=Pathname.new(Dir.getwd).basename.to_s})"
      @repo_name = !(name=STDIN.gets.chomp).empty? ? name : cwd
      if repository_exists?
        puts `echo "\033[1;31mRepository already exists! Choose a different name\033[0m"`
        get_repo_info
      end
      puts "Description: (Press enter to skip)"
      @repo_desc = STDIN.gets.chomp
      puts "Is this a private repository? (y) or (n)"
      @isPrivate = ['y','Y'].include?(STDIN.gets.chomp)
      @options = {}
      @options['description'] = @repo_desc  if !@repo_desc.empty?
      @options['private'] = 'true' if @isPrivate
    end

    def create_repository
      @repo = @client.create_repository(@repo_name,@options)
      puts `echo "\033[0;32mRepository created!\033[0m"` if @repo
      puts `sudo git init`
      puts `sudo git remote add origin #{@repo[:html_url]}.git` 
      puts `sudo git add --all`
      puts `sudo git commit -m "Set up remote repository"`
      puts `sudo git push -u origin master`
      puts `echo "\033[0;32mAll set now!\033[0m"`
    end

    def repository_exists?
      repo = @client.repository(@username+"/"+@repo_name); nil
      true
      rescue
        false
    end

  end
end