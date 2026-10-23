class PlayersController < ApplicationController
  def index
    @result = ColtsNation::ApiClient.fetch_players

    if @result&.success?
      @players = @result.players.group_by do |player|
        stats = player["season_stats"]
        current_year_stats = stats&.max_by { |s| s["year"].to_i } || stats&.first
        current_year_stats&.dig("status") || player["status"] || "Unknown"
      end
    else
      @players = {}
      error_type = @result&.error || :network_error

      flash[:alert] = if error_type == :upstream_error
        "Unable to process your request. Please try again."
      else
        "Unable to connect to the Colts API."
      end
    end
  end
end
