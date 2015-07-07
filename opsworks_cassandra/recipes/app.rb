#
# Cookbook Name:: opsworks_cassandra
# Recipe:: app
#
# Copyright 2015, Scispike, Inc.

hosts = []
node[:opsworks][:layers][node[:cassandra][:opsworks][:layer]][:instances].each do |instanceName,instance|
  Chef::Log.info("pusing ip for #{instanceName}.")
  hosts.push(instance[:private_ip])
end

node[:deploy].each do |application, deploy|
  node.set[:deploy][application][:environment_variables]["CASSANDRA_HOSTS"]=hosts.join(',')
end