#
# Cookbook Name:: memcached
# Provider:: pool
#
# Copyright 2014, Gabor Szelcsanyi <szelcsanyi.gabor@gmail.com>

def whyrun_supported?
  true
end

action :remove do
	service "memcached-#{new_resource.name}" do
		action [:stop, :disable]
	end

	file "/etc/init.d/memcached-#{new_resource.name}" do
		action :delete
	end

	file "/etc/memcached_#{new_resource.name}.conf" do
		action :delete
	end
end

action :create do
	Chef::Log.info("Memcached pool: #{new_resource.name}")

	package "memcached" do
		action :install
	end

	t = template '/etc/init.d/memcached-' + new_resource.name do
		source "etc/init.d/memcached_pool.erb"
		cookbook "memcached"
		owner "root"
		group "root"
		mode "0755"
		variables(:name => new_resource.name)
	end
	new_resource.updated_by_last_action(t.updated_by_last_action?)

	t = template '/etc/memcached_' + new_resource.name + '.conf' do
		source "etc/memcached_pool.conf.erb"
		cookbook "memcached"
		owner "root"
		group "root"
		mode "0644"
		variables(
			:name => new_resource.name,
			:size => new_resource.size,
			:tcp_port => new_resource.tcp_port,
			:udp_port => new_resource.udp_port,
			:listen => new_resource.listen,
			:connection_limit => new_resource.connection_limit,
			:repcache_port => new_resource.repcache_port,
			:repcache_listen => new_resource.repcache_listen,
			:verbose => new_resource.verbose
		)
		notifies :restart, "service[memcached-#{new_resource.name}]", :delayed
	end
	new_resource.updated_by_last_action(t.updated_by_last_action?)

	service "memcached-#{new_resource.name}" do
		action [:enable, :start]
		supports :status => true, :restart => true
	end

end
