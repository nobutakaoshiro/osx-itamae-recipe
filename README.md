
# Target Environment

- OSX 10.10.4

# Requirement

- Xcode & Command line tools

# Usage

```
## Update rubygems and Install bundler
sudo gem update --system
sudo gem install bundler

## git clone this repository to local
git clone https://github.com/nobutakaoshiro/osx-itamae-recipe.git
cd osx-itamae-recipe

## Install Itamae
bundle install

## apply recipe to localhost
bundle exec itamae local recipe.rb

# or

## apply recipe to remote server
bundle exec itamae ssh --host host001.example.com recipe.rb
```

# What's this recipe?

- Install rbenv & plugins in global environment
	- Install rbenv to /usr/local/rbenv
	- Install ruby-build to /usr/local/rbenv/plugins/ruby-build
	- Install rbenv-gem-rehash to /usr/local/rbenv/plugins/rbenv-gem-rehash
	- Install rbenv-update to /usr/local/rbenv/plugins/rbenv-update
  - Install rbnev-default-gems to /usr/local/rbenv/plugins/rbenv-default-gems
	- Install Ruby 2.2.2
  - Install Homebrew
	- Install pip
	- Install AWS CLI
