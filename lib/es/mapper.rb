module Mapper
  def self.bulk
    return unless block_given?
    yield Client.instance
  end
end
