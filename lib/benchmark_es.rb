require 'rubygems'
require 'bundler/setup'
require 'elasticsearch'
require_relative 'es/client'
require_relative 'es/mapper'
require_relative 'es/index_flat_data'
require_relative 'es/index_nested_data'
require_relative 'es/actions/update'
require_relative 'es/actions/all_ids'
require_relative 'es/actions/searcher'

module BenchmarkEs
  extend IndexFlatData
  extend IndexNestedData
  extend Update
  extend AllIds
  extend Searcher
end

def flat
  printf "[%s] Start indexing\n", Time.now
  BenchmarkEs.index_flat(nums: 100)
  printf "[%s] Finish indexing\n-----\n", Time.now

  printf "[%s] Start list all ids \n", Time.now
  ids = BenchmarkEs.all_ids(batch_size: 5000)
  printf "[%s] Finish list all ids \t Total %d \n-----\n", Time.now, ids.count

  printf "[%s] Start updating \n", Time.now
  BenchmarkEs.update_info(ids: ids, batch_size: 5000)
  printf "[%s] Finish updating\n-----\n", Time.now

  printf "[%s] Start do 30 times searching for 10.000 docs\n", Time.now
  30.times do |i|
    search_ids = (i..(i + 10_000)).to_a
    stime = Time.now
    result = BenchmarkEs.search(search_ids)
    etime = Time.now
    printf "\t* Loop %d\t Total %s\t Finish in %f \n", i, result["hits"]["hits"].count, etime - stime
  end

  printf "[%s] Finish searching \n-----\n", Time.now
end

def nested
  BenchmarkEs.index_nested(nums: 100)
end
nested

