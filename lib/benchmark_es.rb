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

def main
  #printf "Start index %s \n", Time.now
  #BenchmarkEs.index_flat_data(nums: 50)
  #printf "Finish index %s \n-----\n", Time.now

  printf "[%s] Start list all ids \n", Time.now
  ids = BenchmarkEs.all_ids(batch_size: 5000)
  printf "[%s] Finish list all ids \t Total %d \n-----\n", Time.now, ids.count

  printf "[%s] Start updating all the info\n", Time.now
  BenchmarkEs.update_info(ids: ids, batch_size: 5000)
  printf "[%s] Finish updating\n-----\n", Time.now
end

main
