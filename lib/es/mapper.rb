module Mapper
  def self.bulk(data, batch_size=10_000, type="room_date")
    data.each_slice(batch_size) do |slice|
      Client.instance.bulk(
        body: slice,
        index: Client.index,
        type: type
      )
    end
  end
end
