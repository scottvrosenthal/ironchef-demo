=begin
# retrieve environment specific data bag item
env = Chef::DataBagItem.load('environments', node['chef_environment'])
Chef::Log.info("Loaded environments information from DataBagItem env[#{env['id']}]")
Chef::Log.info("Loaded environments information from DataBagItem env[#{env['description']}]")

# retrieve global settings specific data bag item
gs_default = Chef::DataBagItem.load('global_settings', 'default')
Chef::Log.info("Loaded global settings information from DataBagItem gs_default[#{gs_default['id']}]")
Chef::Log.info("Loaded global settings information from DataBagItem gs_default[#{gs_default['description']}]")
=end


execute 'yum-config-manager --quiet --enable epel' do
  not_if "yum-config-manager epel | grep 'enabled = True'"
end

execute 'yum update -y'

# packages to remove
%w(
landscape-common
landscape-client
).each do |pkg|
  package pkg do
    action :purge
  end
end

# packages to install
%w(
gcc gcc-c++ 
compat-libstdc++-33
libstdc++-devel
elfutils-libelf-devel
sysstat
glibc-devel
libaio-devel
libxml2 libxml2-devel 
libxslt libxslt-devel
vim-enhanced screen procps
sqlite-devel ntp wget curl
zlib zlib-devel curl-devel
ImageMagick ImageMagick-devel
libyaml-devel libffi-devel
autoconf automake libtool bison
make openssl openssl-devel
git expect pcre pcre-devel
readline-devel
).each do |pkg|
  package pkg do
    retries 2
    retry_delay 10
    action :install
  end
end

execute 'yum clean dbcache'
