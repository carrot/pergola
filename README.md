# Pergola

Simple Ruby wrapper for the Vine API.

## Installation

    sudo gem install Pergola
    
## Usage

You'll need a Vine client.

    require 'Pergola'
    client = Pergola::Client.new(:username => "email", :password => "sekret")
    
If you'd like you can include your username and password in `lib/pergola/configuration.rb` and this will reconfigure your client in the event that you client fails.
    
### Retrieving info

    client.me                   #=> your profile
    client.profile              #=> your profile
    client.profile(123467890)   #=> some user's profile
    client.timeline             #=> your timeline
    client.timeline(123467890)  #=> some user's timeline
    client.popular              #=> 99 popular vines
    client.get_notifications    #=> get notifications
    client.with_tag("tag")      #=> get vines with a tag
    client.logout               #=> logout
    
## How to contribute
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

* Hat tip to [Starlock](https://github.com/starlock/vino/wiki/API-Reference) for providing the basis of the API.

Copyright (c) 2013 [Carrot Creative](http://carrotcreative.com). See LICENSE for details.
