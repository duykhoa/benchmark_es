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

def flat(nums = 100)
  printf "[%s] Start indexing\n", Time.now
  BenchmarkEs.index_flat(nums: nums)
  printf "[%s] Finish indexing\n-----\n", Time.now

  printf "[%s] Start list all ids \n", Time.now
  ids = BenchmarkEs.all_ids()
  printf "[%s] Finish list all ids \t Total %d \n-----\n", Time.now, ids.count

  printf "[%s] Start updating \n", Time.now
  BenchmarkEs.update_info(ids: ids)
  printf "[%s] Finish updating\n-----\n", Time.now

  printf "[%s] Start do 100 times searching for 10.000 docs\n", Time.now
  100.times do |i|
    search_ids = (i..(i + nums)).to_a
    stime = Time.now
    result = BenchmarkEs.search(search_ids)
    etime = Time.now
    printf "\t* Loop %d\t Total %s\t Finish in %f \n", i, result["hits"]["hits"].count, etime - stime
  end

  printf "[%s] Finish searching \n-----\n", Time.now
end

def nested(nums = 100)
  printf "[%s] Start indexing\n", Time.now
  BenchmarkEs.index_nested(nums: nums)
  printf "[%s] Finish indexing\n-----\n", Time.now

  printf "[%s] Start list all ids \n", Time.now
  ids = BenchmarkEs.all_ids(type: "room")
  printf "[%s] Finish list all ids \t Total %d \n-----\n", Time.now, ids.count

  printf "[%s] Start updating rooms\n", Time.now
  BenchmarkEs.update_info(ids: ids, type: "room")
  printf "[%s] Finish updating rooms\n-----\n", Time.now

  printf "[%s] Start list all date_ids \n", Time.now
  date_ids = BenchmarkEs.all_ids(type: "room_date")
  printf "[%s] Finish list all date_ids \t Total %d \n-----\n", Time.now, date_ids.count

  printf "[%s] Start updating dates \n", Time.now
  BenchmarkEs.update_info(ids: date_ids, type: "room_date")
  printf "[%s] Finish updating\n-----\n", Time.now

  printf "[%s] Start do 100 times searching %d room\n", Time.now, nums
  100.times do |i|
    search_ids = (0..nums).to_a
    stime = Time.now
    result = BenchmarkEs.search(search_ids, "room")
    etime = Time.now
    printf "\t* Loop %d\t Total %s\t Finish in %f \n", i, result["hits"]["hits"].count, etime - stime
  end

  printf "[%s] Start do 100 times searching for 10.000 docs\n", Time.now
  100.times do |i|
    search_ids = (i..(i + nums)).to_a
    stime = Time.now
    result = BenchmarkEs.search(search_ids)
    etime = Time.now
    printf "\t* Loop %d\t Total %s\t Finish in %f \n", i, result["hits"]["hits"].count, etime - stime
  end

  printf "[%s] Finish searching \n-----\n", Time.now
end

#flat(100)
nested(100)
