maintainer       "Gabor Szelcsanyi"
maintainer_email "szelcsanyi.gabor@gmail.com"
license          "MIT"
description      "Installs/Configures memcached"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name             "memcached"
version          "1.0.0"

%w{ ubuntu debian }.each do |os|
  supports os
end