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
case node.platform_family
  when "debian"
   include_recipe "apt"
end

user node.nodejs.user do
  system true
  shell "/bin/false"
end

::Chef::Resource.send(:include, Switchpt::Helpers)

include_recipe "nodejs::install_from_#{node.nodejs.install_method}"
