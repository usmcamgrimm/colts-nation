class PlayersController < ApplicationController
  def index
    result = ColtsNation::ApiClient.fetch_players

    if @result.success?
      @players = @result.players
    else
      @players = []
      error_type = @result&.error || :network_error

      flash.now[:alert] = case @result.error
      when :upstream_error
        "The Colts API experienced a problem. Please try your request again."
      when :network_error
        "Unable to connect to the Colts API."
      else
        "An unexpected error occurred."
      end
    end
  end
end
