module Pergola
  class Configuration
    attr_accessor :username, :password

    def initialize
      @username  = 'email'
      @password  = '1234567890ABC'
    end
  end

  class << self
    attr_accessor :configuration
  end

  # Configure Pergola someplace sensible,
  # like config/initializers/Pergola.rb
  #
  # use throughout gem with Pergola.configuration.username
  #
  # @example
  #   Pergola.configure do |config|
  #     config.username      = '12343534456457'
  #     config.password      = 'AB12323DNASDA'
  #   end
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end