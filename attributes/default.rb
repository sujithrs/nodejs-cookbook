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

default.nodejs.deployer = 'deployer'
default.nodejs.user = 'nodejs'
default.nodejs.install_method = 'source'

default.nodejs.version = 'v0.10.4'
default.nodejs.source.checksum.sha1sum = '901c1410b7c28a79644292567d3384255f3a6274'
default.nodejs.source.url = "http://nodejs.org/dist"
default.nodejs.source.dir = "/usr/local/src/nodejs"
default.nodejs.source.make_threads = node.cpu ? node.cpu.total.to_i : 2

default.nodejs.dir = '/usr/local/nodejs'
