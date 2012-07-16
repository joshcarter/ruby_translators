require 'rubygems'
require 'test/unit'
require 'thread'
require 'mocha'
require 'stringio'
require 'pp'

require_relative '../lib/translator'
require_relative '../lib/rot13_translator'
require_relative '../lib/block_translator'
require_relative '../lib/verify_translator'

Thread.abort_on_exception = true
