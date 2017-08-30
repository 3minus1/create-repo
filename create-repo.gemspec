Gem::Specification.new do |s|
  s.name        = 'create-repo'
  s.add_dependency 'octokit', '~> 4.0'
  s.executables   = ["create-repo"]
  s.version     = '1.0.0'
  s.date        = '2017-08-29'
  s.summary     = "Create github repository from terminal"
  s.description = "create-repo is a ruby gem that automatically creates a Github repository and pushes your local repo to the remote repo. No need to go to the browser and sign in to Github."
  s.authors     = ["Akshat Karnwal"]
  s.email       = 'akforsn@gmail.com'
  s.files       = %w(LICENSE.md README.md create-repo.gemspec)
  s.files       += Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/3minus1/create-repo'
  s.license       = 'MIT'
  s.required_ruby_version = '>= 2.0.0'
end