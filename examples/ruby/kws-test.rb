#!/usr/bin/env ruby
require 'faye/websocket'
require 'eventmachine'
require 'json'

ws_host = 'kafka-000-staging.mistsys.net'
ws_port = 7080
cnt = 0

EM.run {
  ws = Faye::WebSocket::Client.new("ws://#{ws_host}:#{ws_port}/v2/broker/?topics=my_topic,other_topic?group.id=my_group_id")
  puts "cnt: #{cnt}"
  ws.on :open do |event|
    p [:open]
    # msg = {:topic => "my_topic", :message => "my awesome message"}
    msg = { "topic" => "my_topic", "message" => "my amazing message" }
    ws.send(msg.to_json)
  end

  ws.on :message do |event|
    p [:message, event.data]
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}
