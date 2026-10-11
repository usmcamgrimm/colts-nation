module ColtsNation
  class ApiClient
    include HTTParty
    BASE_URI = ENV.fetch("COLTS_API_URL", "https://colts-api.onrender.com")
    default_timeout 30 # allow for cold start on Render

    Result = Struct.new(:players, :seasons, :error, keyword_init: true) do
      def success? = error.nil?
    end

    def self.fetch_players
      cache_key = "colts_nation:players"

      cached_result = Rails.cache.read(cache_key)
      return cached_result if cached_result&.success?

      response = get("#{BASE_URI}/api/v1/players", format: :json)

      if response.success?
        result = Result.new(players: response.parsed_response)
        Rails.cache.write(cache_key, result, expires_in: 1.hour)
        result
      else
        Rails.logger.warn("[ColtsNation] upstream error code: #{response.code}")
        Result.new(players: [], error: :upstream_error)
      end
    rescue StandardError => e
      Rails.logger.warn("[ColtsNation] network error: #{e.class}: #{e.message}")
      Result.new(players: [], error: :network_error)
    end

    def self.seasons
      cache_key = "colts_nation:seasons"

      cached_result = Rails.cache.read(cache_key)
      return cached_result if cached_result&.success?

      response = get("#{BASE_URI}/api/v1/seasons", format: :json)

      if response.success?
        result = Result.new(seasons: response.parsed_response)
        Rails.cache.write(cache_key, result, expires_in: 1.hour)
        result
      else
        Rails.logger.warn("[ColtsNation] upstream error code: #{response.code}")
        Result.new(seasons: [], error: :upstream_error)
      end
    rescue StandardError => e
      Rails.logger.warn("[ColtsNation] network error: #{e.class}: #{e.message}")
      Result.new(seasons: [], error: :network_error)
    end
  end
end
