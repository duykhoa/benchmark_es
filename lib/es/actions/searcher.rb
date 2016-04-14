module Searcher
  def search(ids)
    Client.instance.search(
      index: Client.index,
      type: "room_date",
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
                  max_guest: {
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
