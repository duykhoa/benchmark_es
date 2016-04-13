module Update
  YEARS = 365

  def update_info(nums:)
    Mapper.bulk(update_data(nums))
  end

  def update_data(nums)
    (0...nums).inject([]) do |r, id|
      (0...365).each do |x|
        d =
          {
          update:
          {
            _id: id,
            data: {
              doc: {
                max_guest: 11
              }
            }
          }
        }

        r << d
      end
      r
    end
  end
end
