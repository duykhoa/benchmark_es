require 'date'

module IndexNestedData
  YEARS = 365

  def index_nested(nums:)
    (0...nums).each_slice(100) do |slice|
      Mapper.bulk(room_data(slice), 10_000, "room")

      data = (slice.first .. slice.last).inject([]) do |r, x|
        r.concat index_nested_data(x)
      end

      Mapper.bulk(data)
    end
  end

  private

  def room_data(slice)
    slice.map do |x|
      {
        index:
        {
          data: {
            room_id: x,
            unit_id: nil,
            att1: 1,
            att2: 1,
            att3: 1,
            att4: 1,
            att5: 1,
            att6: 1,
            att7: 1,
            att8: 1,
            att9: 1,
            att10: 1,
            att11: 1,
            att12: 1,
            att13: 1,
            att14: 1,
            att15: 1,
            att16: 1,
            att17: 1,
            att18: 1,
            att19: 1,
            att20: 1,
            att21: 1,
            att22: 1,
            att23: 1,
            attr: 0
          }
        }
      }
    end
  end

  def index_nested_data(x)
    r = []

    YEARS.times do |y|
      d =
        {
          index:
          {
            data: sample_nested_data(x, nil, Date.today + y)
          }
        }
      r << d
    end

    r
  end

  def sample_nested_data(room_id, unit_id, date)
    {
      room_id: room_id,
      unit_id: unit_id,
      dates: date.strftime("%Y-%m-%d"),
      daily_price: 100,
      daily_confidence: 1,
      weekly_price: 100,
      weekly_confidence: 2,
      monthly_price: 100,
      monthly_confidence: 3,
      attr: 0
    }
  end
end
