rbenv_root = '/usr/local/rbenv'
rbenv_path = '${RBENV_ROOT}/bin:${PATH}'
rbenv_env  = "RBENV_ROOT=#{rbenv_root} PATH=#{rbenv_path}" 
shell_config = "~/.zshrc"
ruby_version = "2.2.2"

execute "add_rbenv_path" do
  command %Q|echo 'export RBENV_ROOT=#{rbenv_root}\nexport PATH="#{rbenv_path}"\neval "$(rbenv init -)"' >> #{shell_config}|
  not_if "grep RBENV_ROOT #{shell_config}"
  notifies :run, "execute[restart_shell]", :immediately
end

execute "restart_shell" do
  action :nothing
  command "exec $SHELL -l"
end

execute "install_rbenv" do
  command "#{rbenv_env} git clone git://github.com/sstephenson/rbenv.git ${RBENV_ROOT}"
  not_if "test -d #{rbenv_root}"
  notifies :run, "execute[update_rbenv]", :delayed
end

directory "/usr/local/rbenv/plugins" do
  action :create
  only_if "test -d #{rbenv_root}"
  notifies :run, "execute[update_rbenv]", :delayed
end

execute "install_ruby-build" do
  command "#{rbenv_env} git clone https://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build"
  not_if "test -d #{rbenv_root}/plugins/ruby-build"
  notifies :run, "execute[update_rbenv]", :delayed
end

execute "install_rbenv-gem-rehash" do
  command "#{rbenv_env} git clone https://github.com/sstephenson/rbenv-gem-rehash.git ${RBENV_ROOT}/plugins/rbenv-gem-rehash" 
  not_if "test -d #{rbenv_root}/plugins/rbenv-gem-rehash"
  notifies :run, "execute[update_rbenv]", :delayed
end

execute "install_rbenv-update" do
  command "#{rbenv_env} git clone https://github.com/rkh/rbenv-update.git ${RBENV_ROOT}/plugins/rbenv-update"
  not_if "test -d #{rbenv_root}/plugins/rbenv-update"
  notifies :run, "execute[update_rbenv]", :delayed
end

execute "install_rbenv-default-gems" do
  command "#{rbenv_env} git clone https://github.com/sstephenson/rbenv-default-gems.git ${RBENV_ROOT}/plugins/rbenv-default-gems"
  not_if "test -d #{rbenv_root}/plugins/rbenv-default-gems"
  notifies :run, "execute[update_rbenv]", :delayed
end

template "/usr/local/rbenv/default-gems" do
  source "./templates/default-gems.erb"
end

execute "update_rbenv" do
  action :nothing
  command "rbenv update"
end

execute "install_ruby" do
  command "rbenv install #{ruby_version} && rbenv global #{ruby_version} && rbenv shell #{ruby_version} && gem update --system"
  not_if "test -d #{rbenv_root}/versions/#{ruby_version}"
end


## Homebrew
execute "install_homebrew" do
  command 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && exec $SHELL -l'
  not_if "type brew"
end

## pip for python
execute "easy_install pip" do
  command "sudo easy_install pip && exec $SHELL -l"
  not_if "type pip"
end

## AWS CLI
execute "install AWS CLI" do
  command "sudo pip install awscli && exec $SHELL -l"
  not_if "type aws"
end
