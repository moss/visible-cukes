$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

require 'rubygems'
require 'spec'
require 'webrat'

Spec::Runner.configure do |config|
  include Webrat::Methods
 
  def with_html(html)
    raise "This doesn't look like HTML. Wrap it in a <html> tag" unless html =~ /^\s*<[^Hh>]*html/i
    webrat_session.response_body = html
  end
end

class FakeAdapter
  extend Forwardable
  attr_accessor :response_body

  def initialize(session)
    @session = session
  end

  def response
    response_body
  end
end

module Webrat
  def self.adapter_class
    FakeAdapter
  end
end
 

