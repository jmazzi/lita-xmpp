# lita-xmpp

[![Build Status](https://travis-ci.org/jmazzi/lita-xmpp.png?branch=master)](https://travis-ci.org/jmazzi/lita-xmpp)
[![Code Climate](https://codeclimate.com/github/jmazzi/lita-xmpp.png)](https://codeclimate.com/github/jmazzi/lita-xmpp)
[![Coverage Status](https://coveralls.io/repos/jmazzi/lita-xmpp/badge.png)](https://coveralls.io/r/jmazzi/lita-xmpp)

**lita-xmpp** is an adapter for [Lita](https://github.com/jimmycuadra/lita) that allows you to use the robot with [HipChat](https://www.hipchat.com/).

## Installation

Add lita-xmpp to your Lita instance's Gemfile:

``` ruby
gem "lita-xmpp"
```

## Configuration


### Required attributes

* `jid` (String) - The JID of your robot's account. Default: `nil`.
* `password` (String) - The password for your robot's account. Default: `nil`.

### Optional attributes

* `debug` (Boolean) - If `true`, turns on the underlying Jabber library's (xmpp4r) logger, which is fairly verbose. Default: `false`.
* `rooms` (Symbol, Array<String>) - An array of room JIDs that Lita should join upon connection. Can also be the symbol `:all`, which will cause Lita to discover and join all rooms. Default: `nil` (no rooms).
* `muc_domain` (String) - The XMPP Multi-User Chat domain to use. 

There's no need to set `config.robot.mention_name` manually. The adapter will load the proper mention name from the XMPP roster upon connection.

### Example

``` ruby
Lita.configure do |config|
  config.robot.name = "Lita Bot"
  config.robot.adapter = :xmpp
  config.adapter.jid = "12345_123456@myserver.com"
  config.adapter.password = "secret"
  config.adapter.debug = false
  config.adapter.rooms = :all
  config.adapter.muc_domain = "conf.myserver.com"
  config.mention_name = "bot"
end
```

## License

[MIT](http://opensource.org/licenses/MIT)
