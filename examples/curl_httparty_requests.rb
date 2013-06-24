# AUTHENTICATE FIRST found in examples/authenticate.rb

# client is an instance of Pergola::Client

HTTParty.post("https://api.vineapp.com/users/authenticate", body: { username: "example@gmail.com", password: "sekret"})
OR
curl -X POST --data "username=example@gmail.com&password=sekret" https://api.vineapp.com/users/authenticate


# Authenticate
HTTParty.post("https://api.vineapp.com/users/authenticate", body: { username: "example@gmail.com", password: "sekret"})

###############
client.profile

# Get /me
HTTParty.get("https://api.vineapp.com/users/me", :headers => {"vine-session-id" => response["data"]["key"]})

# Get /Lee Ourand
HTTParty.get("https://api.vineapp.com/users/profiles/#{other_user_id}", :headers => { "vine-session-id" => response["data"]["key"] })
curl --header "vine-session-id:#{session}" https://api.vineapp.com/users/profile/"#{other_user_id}"
curl --header "vine-session-id:#{session}" https://api.vine"app.com/users/me"

#################
cient.timeline || client.timeline(":id => "#{other_user_id}") || client.timeline("@twitter_handle")
# Get a user timeline
HTTParty.get("https://api.vineapp.com/timelines/users/908940759363887104", :headers => {"vine-session-id" => response["data"]["key"]})

#####################
client.popular
# Get Popular
HTTParty.get("https://api.vineapp.com/timelines/popular", :headers => {"vine-session-id" => response["data"]["key"]})
curl -H "vine-session-id:#{session}" https://api.vineapp.com/timelines/popular
##################
client.with_tag("tag")

curl -H "vine-session-id:#{session}" https://api.vineapp.com/timelines/tags/carrot

##################
client.get_notifications
curl -H "vine-session-id:#{session}" https://api.vineapp.com/users/"#{user_id}"/pendingNotificationsCount

##############
client.logout
curl -X DELETE -H "vine-session-id:#{session}" https://api.vineapp.com/users/authenticate