module Update
  def update_info(ids:, batch_size: 10_000, type: "room_date")
    ids.each_slice(batch_size) do |slice|
      printf "[%s] Finish update %s - %s\t Count: %d\n", Time.now, slice.first, slice.last, slice.count
      Mapper.bulk(update_data(slice), batch_size, type)
    end
  end

  private

  def update_data(slice)
    slice.map do |id|
      sample_update_data(id)
    end
  end

  def sample_update_data(id)
    {
      update: {
        _id: id,
        data: {
          doc: {
            attr: 999
          }
        }
      }
    }
  end
end
