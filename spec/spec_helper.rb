ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app', __FILE__
require 'rack/test'
require "json"
require "./spec/params_helper"
require "pry"

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }
