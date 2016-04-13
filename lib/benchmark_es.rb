require 'rubygems'
require 'bundler/setup'
require 'elasticsearch'
require_relative 'es/client'
require_relative 'es/mapper'
require_relative 'es/generate'
require_relative 'es/actions/update'
require_relative 'es/actions/all_ids'

module BenchmarkEs
  extend Generate
  extend Update
  extend AllIds
end

printf "Start index %s \n", Time.now
BenchmarkEs.index_flat_data(nums: 50)
printf "Finish index %s \n-----\n", Time.now

printf "Start list all ids %s \n", Time.now
puts BenchmarkEs.all_ids(batch_size: 5000)
printf "Finish list all ids %s \n", Time.now

#BenchmarkEs.update_info(nums: 50)
