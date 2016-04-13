require 'date'

module Generate
  YEARS = 365

  def index_flat_data(nums:)
    Mapper.bulk(index_data(nums))
  end

  private

  def index_data(nums)
    (0...nums).inject ([]) do |r, x|
      YEARS.times do |y|
        d =
          {
            index:
            {
              data: sample_data(x, nil, Date.today + y)
            }
          }
        r << d
      end
      r
    end
  end

  def sample_data(room_id, unit_id, date)
    {
      room_id: room_id,
      unit_id: unit_id,
      max_guest: 10,
      tax_rate: 100,
      min_stays: 3,
      summary: "this is a short content",
      beds: 2,
      fee: 100,
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
      att16: 3,
      att17: 1,
      att18: 1,
      att19: 1,
      dates: date.strftime("%Y-%m-%d"),
      daily_price: 100,
      daily_confidence: 1,
      weekly_price: 100,
      weekly_confidence: 2,
      monthly_price: 100,
      monthly_confidence: 3
    }
  end
end
