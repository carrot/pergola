require_relative 'helper'

class PergolaTest < Test::Unit::TestCase

  context "Pergola Client" do

    def setup
      stub_post("/users/authenticate", "authentication.json")
      @client = Pergola::Client.new(:username => "josh.rowley@gmail.com", :password => "sekret")
      @another_client_id = 907189074719289344
    end

    should "return the attributes of a user" do
      assert_equal @client.user_id, 908940759363887104
      assert_equal @client.session, "908940759363887104-3931d3e3-e22a-40e5-8913-468544543a07"
    end

    should "initialize with a session only" do
      @client = Pergola::Client.new(token: "908940759363887104-3931d3e3-e22a-40e5-8913-468544543a07")
      assert_equal @client.user_id, "908940759363887104"
      assert_equal @client.session, "908940759363887104-3931d3e3-e22a-40e5-8913-468544543a07"
    end


    should "#me" do
      stub_get("/users/me", "profile.json")
      profile = Pergola.me
      assert_equal profile["data"]["userId"], @client.user_id
    end

    should "#profile" do
      stub_get("/users/profiles/#{@client.user_id}", "profile.json")
      profile = Pergola.profile
      assert_equal profile["data"]["userId"], @client.user_id
    end

    should "#profile with a parameter" do
      stub_get("/users/profiles/#{@another_client_id}", "user.json")
      profile = Pergola.profile(907189074719289344)
      assert_not_equal profile["data"]["userId"], @client.user_id
      assert_equal profile["data"]["userId"], @another_client_id
    end

    should '#timeline' do
      stub_get("/timelines/users/#{@client.user_id}", "timeline.json")
      timeline = Pergola.timeline
      assert_equal timeline["data"]['records'][0]["userId"], @client.user_id
    end

    should '#timeline with a parameter' do
      stub_get("/timelines/users/#{@client.user_id}", "timeline.json")
      timeline = Pergola.timeline(@client.user_id)
      assert_equal timeline["data"]['records'][0]["userId"], @client.user_id
    end

    should '#get_notifications' do
      stub_get("/users/#{@client.user_id}/pendingNotificationsCount", "notification.json")
      notification = Pergola.get_notifications
      assert_equal notification["success"], true
    end

    should '#popular' do
      stub_get("/timelines/popular", "popular.json")
      popular = Pergola.popular
      assert_equal popular["success"], true
    end

    should '#with_tag()' do
      tag = "carrot"
      stub_get("/timelines/tags/#{tag}", "tagged.json")
      subject = Pergola.with_tag(tag)
      assert_equal subject["data"]["records"][0]["tags"][0]["tag"], tag
    end

    should '#logout' do
      stub_delete("/users/authenticate", "logout.json")
      logout = Pergola.logout
      assert_equal logout["success"], true
    end

    should "reinitialize with config variables if token fails" do
      stub_get("/users/me", "profile.json")
      @expired_client = Pergola::Client.new(token: "908940759363887104-3931d3e3-e22a-40e5-8913-468544543b32") #note the last 3 digits
      profile = @expired_client.me
      assert_equal profile["data"]["userId"], @client.user_id
    end


  end

end