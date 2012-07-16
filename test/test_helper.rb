require 'rubygems'
require 'test/unit'
require 'thread'
require 'mocha'
require 'stringio'
require 'pp'

require_relative '../lib/writer'
require_relative '../lib/reader'

Thread.abort_on_exception = true
