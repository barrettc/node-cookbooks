#
# Cookbook Name:: cassandra-opsworks
# Recipe:: default
#
# Copyright 2015, Scispike, Inc.

node['opsworks']['instance']['layers'].each do |layer|
	Chef::Log.info("set cluster_name for #{layer}.")
	node.normal[:cassandra][:cluster_name] = node['opsworks']['layers'][layer]['name']
end

node[:opsworks][:instance][:layers].each do |layer,config|
	node.normal[:cassandra][:seeds] = node[layer]["node"]["ips"]
end




