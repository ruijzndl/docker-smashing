#!/usr/bin/env ruby
require_relative '../lib/cesar-aws'

def bool_to_i(b)
  (b) ? 1 : 0
end

def update_cesar_widgets(cesar)
  cesar.load_environments()
  envs = cesar.environments
  
  envs.each do |env_name, envi|
    puts "==#{env_name}=="
    statuses = Array.new()
    env_status = "free"
    env_status_color = "default"
    envi.instances.each do |name,instance|
      puts "  name = #{instance.name} #{instance.id} #{instance.state}"
      result = (instance.state == "running")
      env_status = (result) ? "in use" : env_status
      env_status_color = (result) ? "blue" : env_status_color
      os = (instance.name =~ /^.*kodex$/ ) ? "icon-windows" : "icon-linux"
      arrow = (result) ? "icon-spinner" : "icon-moon"
      color = (result) ? "blue" : "default"
      server = instance.name
      statuses.push({:os=> os, :label => server, :value=> bool_to_i(result), :arrow=> arrow, :color=> color})
    end
    send_event("cesar-#{env_name}", {items: statuses, status: env_status, status_color: env_status_color})
  end  
end
 
region = 'eu-west-1'
cesar = CesarAws.new(region)
SCHEDULER.every '30s', :first_in => 0 do |job|
 update_cesar_widgets(cesar)
end

