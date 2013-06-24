module Pergola
  class Client
    include HTTParty
    base_uri "https://api.vineapp.com"
    format :json
    attr_accessor :session, :user_id  

    # Initialize the Pergola client    
    # E.G.
    # client = Pergola::Client.new(:username => "email", :password => "sekret")

    def initialize(options={})
      if options[:token]
        @session = options[:token]
        @user_id = options[:token].match(/(\d*(?=-))/)[0]
      elsif options[:username] && options[:password]
        response = self.class.post('/users/authenticate', body: {username: options[:username], password: options[:password] })
        @user_id = response["data"]["userId"]
        @session = response["data"]["key"]
      end

      Pergola.session = @session
      Pergola.user_id = @user_id

      @headers = {:headers => {"vine-session-id" => @session}}
    end

    #client.logout #=> destroys the client session
    def logout
      path = "/users/authenticate"
      self.request(path, :delete)
    end

    # client.profile            #=> Your Profile
    # client.me                 #=> Your Profile
    # client.profile('user_id') #=> some user's profile
    def profile(user_id = @user_id)
      path = "/users/profiles/#{user_id}"
      self.request(path)
    end
    
    def me
      path = "/users/me"
      self.request(path)
    end

    #client.timeline #=> your timeline
    #client.timeline('user_id') #=> friend's timeline
    def timeline(user_id = @user_id)
      path = "/timelines/users/#{user_id}"
      self.request(path)
    end

    #client.tag("brooklyn") #=> find vines with similar tags
    def with_tag(tag)
      path = "/timelines/tags/#{tag}"
      self.request(path)
    end

    #client.get_notifications #=> get pending notifications
    def get_notifications
      path = "/users/#{@user_id}/pendingNotificationsCount"
      self.request(path)
    end
    
    #client.popular #=> discover popular vines
    def popular
      path = "/timelines/popular"
      self.request(path)
    end

    def request(path, method=:get)
      request = self.class.send(method, path, @headers)

      if request["code"] != ""
        config = Pergola.configuration
        puts "YOUR SESSION IS NO LONGER VALID"
        puts "REINITIALIZING YOUR SESSION BASED ON CONFIGURATION.RB"

        new_client = self.class.new(username: config.username, password: config.password)
        @headers = {:headers => {"vine-session-id" => new_client.session}}

        puts "RETRYING THE API CALL"
        request = self.class.send(method, path, @headers)
      end
      request
    end

  end
end