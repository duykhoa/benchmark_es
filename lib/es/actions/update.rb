module Update
  def update_info(ids:, batch_size:)
    ids.each_slice(batch_size) do |slice|
      printf "[%s] Finish update %s - %s\t Count: %d\n", Time.now, slice.first, slice.last, slice.count
      Mapper.bulk(update_data(slice))
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
            max_guest: 11
          }
        }
      }
    }
  end
end
