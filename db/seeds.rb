require 'rubygems'
require 'test/blueprints'

Blueprints.announce_nominations
3.times { Player.make }
