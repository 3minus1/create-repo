# create-repo

create-repo is a ruby gem that automatically creates a Github repository and pushes your local repo to the remote repo. No need to go to the browser and sign in to Github.


## Install the gem

Install via Rubygems

    gem install create-repo

Or add to your Gemfile

    gem "create-repo", "~> 1.0.0"

## Using create-repo

Inside your project directory, run

    create-repo

Provide your Github credentials and fill in the repository details as asked by the prompts that follow.

That's it! create-repo will automatically do the following for you:

1. Create a repository on Github
2. Initialize an empty git repository in the current directory
2. Add the remote origin 
3. Add all the untracked files
4. Create an initial commit
5. Push to the remote repository that was just created

