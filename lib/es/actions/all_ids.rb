module AllIds
  def all_ids(batch_size: 10_000, type: 'room_date')
    result = []

    r = Client.instance.search(
      index: Client.index,
      scroll: '5m',
      type: type,
      size: batch_size,
      search_type: 'scan'
    )
    result.concat (r['hits']['hits'].map { |x| x['_id'] })

    while r = Client.instance.scroll(scroll_id: r['_scroll_id'], scroll: '5m') and not r['hits']['hits'].empty? do
      result.concat (r['hits']['hits'].map { |x| x['_id'] })
    end

    result
  end
end
