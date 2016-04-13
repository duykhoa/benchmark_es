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

#BenchmarkEs.index_flat_data(nums: 500)
#BenchmarkEs.update_info(nums: 500)
puts BenchmarkEs.all_ids(batch_size: 5000)
