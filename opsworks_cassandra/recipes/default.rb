#
# Cookbook Name:: opsworks_cassandra
# Recipe:: default
#
# Copyright 2015, Scispike, Inc.

seeds = []
node[:opsworks][:layers][node[:cassandra][:opsworks][:seedLayer]][:instances].each do |instanceName,instance|
  Chef::Log.info("pusing ip for #{instanceName}.")
  seeds.push(instance[:private_ip])
end
node.normal[:cassandra][:seeds]=seeds

include_recipe 'cassandra'