require 'rubygems'
require 'bundler/setup'
require 'elasticsearch'
require_relative 'es/client'
require_relative 'es/mapper'
require_relative 'es/generate'

module BenchmarkEs
  extend Generate
end

BenchmarkEs.index_flat_data(nums: 50000)
