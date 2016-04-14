module Searcher
  def search(ids, type="room_date")
    Client.instance.search(
      index: Client.index,
      type: type,
      size: 10_000,
      body: {
        query: {
          filtered: {
            filter: [
              {
                terms: {
                  room_id: ids
                }
              },
              {
                range: {
                  attr: {
                    gte: 0
                  }
                }
              }
            ]
          }
        }
      }
    )
  end
end
