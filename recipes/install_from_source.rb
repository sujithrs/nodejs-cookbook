# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

case node.platform_family
  when 'rhel','fedora'
    package "openssl-devel"
  when 'debian'
    package "libssl-dev"
end

directory node.nodejs.source.dir  do
  owner node.nodejs.deployer
  group node.nodejs.user
  mode  "0750"
  action :create
end

directory node.nodejs.dir  do
  owner node.nodejs.deployer
  group node.nodejs.user
  mode  "0750"
  action :create
end

src_file = "node-#{node.nodejs.version}.tar.gz"
src_url = "#{node.nodejs.source.url}/#{node.nodejs.version}/#{src_file}"
loc_file = "/usr/local/src/nodejs/#{src_file}"
loc_dir = "/usr/local/src/nodejs/node-#{node.nodejs.version}"
bin_file = "#{node.nodejs.dir}/bin/node"

remote_file loc_file do
  owner node.nodejs.deployer
  group node.nodejs.user
  source src_url
  mode 0640
  action :create_if_missing
end

execute "tar -zxf #{src_file}" do
  user node.nodejs.deployer
  cwd "/usr/local/src/nodejs"
  creates loc_dir
  only_if { shasum_matches?(loc_file, node.nodejs.source.checksum) } 
end

bash "compile node.js (on #{node.nodejs.source.make_threads} cpu)" do
  user node.nodejs.deployer
  cwd loc_dir
  code <<-EOH
    PATH="/usr/local/bin:$PATH"
    ./configure --prefix=#{node.nodejs.dir} && make -j #{node.nodejs.source.make_threads}
  EOH
  creates "#{loc_dir}/node"
end

execute "nodejs make install" do
  user node.nodejs.deployer
  environment({"PATH" => "/usr/local/bin:/usr/bin:/bin:$PATH"})
  command "make install"
  cwd loc_dir
  not_if {File.exists?(bin_file) && `#{bin_file} --version`.chomp == node.nodejs.version }
end

execute "change group" do
  cwd node.nodejs.dir
  command "chown -R #{node.nodejs.deployer}:#{node.nodejs.user} #{node.nodejs.dir}"
end
