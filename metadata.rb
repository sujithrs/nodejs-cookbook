name              "nodejs"
maintainer        "SwitchPoint, Inc."
maintainer_email  "cookbooks@switchpt.com"
license           "Apache 2.0"
description       "Installs/Configures nodejs"
version           "0.0.1"

recipe "nodejs", "Installs node.js - default installation "
recipe "nodejs::install_from_source", "Installs node.js from source"

depends "build-essential"
depends "apt"

%w{ debian ubuntu }.each do |os|
    supports os
end

depends "helpers"
