module Client
  def self.instance
    @client ||= Elasticsearch::Client.new(
      host: ENV['ES_URL']
    )
  end

  def self.index
    ENV['ES_INDEX']
  end
end
