module ColtsNation
  class ApiClient
    include HTTParty
    BASE_URI = ENV.fetch("COLTS_API_URL", "https://colts-api.onrender.com")
    default_timeout 5

    Result = Struct.new(:players, :seasons, :error, keyword_init: true) do
      def success? = error.nil?
    end

    def self.fetch_players
      Rails.cache.fetch("colts_nation:players", expires_in: 1.hour) do
        response = get("/api/v1/players", format: :json)
        if response.success?
          Result.new(players: response.parsed_response)
        else
          Rails.logger.warn("[ColtsNation] upstream #{response.code}")
          nil
        end
      end || Result.new(players: [], error: :upstream_error)
    rescue HTTParty::Error, SocketError, Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNREFUSED => e
      Rails.logger.warn("[ColtsNation] network error: #{e.class}: #{e.message}")
      Result.new(players: [], error: :network_error)
    end

    def self.seasons
      Rails.cache.fetch("colts_nation:seasons", expires_in: 1.hour) do
        response = get("/api/v1/seasons", format: :json)
        if response.success?
          Result.new(seasons: response.parsed_response)
        else
          Rails.logger.warn("[ColtsNation] upstream #{response.code}")
        end
      end || Result.new(players: [], error: :upstream_error)
    rescue HTTParty::Error, SocketError, Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNREFUSED => e
      Rails.logger.warn("[ColtsNation] network error: #{e.class}: #{e.message}")
      Result.new(seasons: [], error: :network_error)
    end
  end
end
