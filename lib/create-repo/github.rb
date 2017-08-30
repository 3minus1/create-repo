require 'io/console'
require 'pathname'
module CreateRepo
  class Github
    #attr_accessor :username, :password, :repo_name, :repo_desc, :isPrivate, :options, :repo, :client

    def initialize
      puts "Github Username: "
      @username = STDIN.gets.chomp
      puts "Github Password: "
      @password = STDIN.noecho(&:gets).chomp
    
    end

    def login
        puts "Logging in..."
        @client = Octokit::Client.new \
          :login    => "#{@username}",
          :password => "#{@password}"
      user = @client.user
      user.login 
    end

    def get_repo_info
      puts "Repository Name: (default: #{cwd=Pathname.new(Dir.getwd).basename.to_s})"
      @repo_name = !(name=STDIN.gets.chomp).empty? ? name : cwd
      puts "Description: (Press enter to skip)"
      @repo_desc = STDIN.gets.chomp
      puts "Is this a private repository? (y) or (n)"
      @isPrivate = ['y','Y'].include?(STDIN.gets.chomp)
      @options = {}
      @options['description'] = @repo_desc  if !@repo_desc.empty?
      @options['private'] = 'true' if @isPrivate
      #todo: Check if repo already exists.. 
    end

    def create_repository
      @repo = @client.create_repository(@repo_name,@options)
      puts `echo -e "\033[0;32mRepository created!\033[0m"` if @repo
      puts `sudo git init`
      puts `sudo git remote add origin #{@repo[:html_url]}.git` 
      puts `sudo git add --all`
      puts `sudo git commit -m "Set up remote repository"`
      puts `sudo git push -u origin master`
      puts `echo -e "\033[0;32mAll set now!\033[0m"`

#      puts "All set now"
    end

  end
end