require 'httparty'
require 'hashie'

Hash.send :include, Hashie::HashExtensions

module Pergola

  def self.logout
    Pergola::Client.new(token: "#{Pergola.session}").logout
  end

  def self.profile(user_id= @user_id)
    Pergola::Client.new(token: "#{Pergola.session}").profile(user_id)
  end

  def self.me
    Pergola::Client.new(token: "#{Pergola.session}").me
  end

  def self.timeline(user_id = @user_id)
    Pergola::Client.new(token: "#{Pergola.session}").timeline(user_id)
  end
  
  def self.with_tag(tag)
    Pergola::Client.new(token: "#{Pergola.session}").with_tag(tag)
  end
  
  def self.get_notifications
    Pergola::Client.new(token: "#{Pergola.session}").get_notifications
  end

  def self.popular
    Pergola::Client.new(token: "#{Pergola.session}").popular
  end

  def self.configuration
    Pergola::Configuration.new
  end

  # def self.client_extension(*args)
  #   args.each do |arg|
  #     define_method self.send(arg) do
  #       Pergola::Client.new(token: "#{Pergola.session}").send(arg)
  #     end
  #   end
  # end
  # self.client_extension(:logout, :profile, :me, :timeline, :get_notifications, :popular)


  class << self
    attr_accessor :session, :user_id
  end

  autoload :Version,        "pergola/version"
  autoload :Client,         "pergola/client"
  autoload :Configuration,  "pergola/configuration"
end

