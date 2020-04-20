Restart Butler
==============

Use restart butler to DRY down your script/restart code

Usage
-----

```ruby
# Gemfile
gem 'restart_butler', :git => "git://github.com/futuresimple/restart_butler.git", :branch => "master"
```

```ruby
# script/restart
root_dir   = File.expand_path(File.join(File.dirname(__FILE__), '..'))
rails_env  = ENV['RAILS_ENV'] || 'development'

require "rubygems"
require "bundler/setup"
require "restart_butler"

butler = RestartButler::Base.new(root_dir, oldrev, newrev, {"RAILS_ENV" => rails_env})
# add steps, i.e.
butler.steps << :bundle
butler.steps << [:asset, {:destination => "user@host:/some/path"}]
butler.steps << :migrate
butler.steps << [:god, {:god_path => "config/quotebase.god"}]
butler.steps << :cron if ENV["CRON"] == "true"
butler.steps << :delayed
butler.restart!
```

## Copyright and license

Copyright 2020 Zendesk

Licensed under the [Apache License, Version 2.0](LICENSE)
