#
# Cookbook Name:: cassandra-opsworks
# Recipe:: default
#
# Copyright 2015, Scispike, Inc.

node['opsworks']['instance']['layers'].each do |layer|
	Chef::Log.info("set cluster_name for #{layer}.")
	node.normal[:cassandra][:cluster_name] = node['opsworks']['layers'][layer]['name']
end
seeds = []
node[:opsworks][:instance][:layers].each do |layer,config|
  node[:opsworks][:layers][layer][:instances].each do |instanceName,instance|
    Chef::Log.info("pusing ip for #{instanceName}.")
    seeds.push(instance[:private_ip])
  end
end
node.normal[:cassandra][:seeds]=seeds




