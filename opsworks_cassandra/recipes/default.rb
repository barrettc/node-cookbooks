#
# Cookbook Name:: opsworks_cassandra
# Recipe:: default
#
# Copyright 2015, Scispike, Inc.

node[:opsworks][:instance][:layers].each do |layer|
  if node[:cassandra][:opsworks][:seedLayer] != layer
    Chef::Log.info("set cluster_name for #{layer}.")
    node.normal[:cassandra][:cluster_name] = node[:opsworks][:layers][layer][:name]
  end
end

seeds = []
node[:opsworks][:layers][node[:cassandra][:opsworks][:seedLayer]][:instances].each do |instanceName,instance|
  Chef::Log.info("pushing ip for #{instanceName}.")
  seeds.push(instance[:private_ip])
end
node.normal[:cassandra][:seeds]=seeds

include_recipe 'cassandra'
