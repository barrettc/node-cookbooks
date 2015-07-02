#
# Cookbook Name:: opsworks_cassandra
# Recipe:: default
#
# Copyright 2015, Scispike, Inc.

require 'set'
seeds = Set.new []
node[:opsworks][:instance][:layers].each do |layer|
  Chef::Log.info("set cluster_name for #{layer}.")
  node.normal[:cassandra][:cluster_name] = node[:opsworks][:layers][layer][:name]
  
  node[:opsworks][:layers][layer][:instances].each do |instanceName,instance|
    Chef::Log.info("pusing ip for #{instanceName}.")
    seeds.add(instance[:private_ip])
  end
end
Chef::Log.info("removing self from seeds leaving #{seeds.delete?(node[:opsworks][:instance][:private_ip])}.")

node.normal[:cassandra][:seeds]=seeds.to_a

include_recipe 'cassandra'