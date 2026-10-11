class PlayersController < ApplicationController
  def index
    @result = ColtsNation::ApiClient.fetch_players

    if @result&.success?
      @players = @result.players
    else
      @players = []
      error_type = @result&.error || :network_error

      flash[:alert] = if error_type == :upstream_error
        "Unable to process your request. Please try again."
      else
        "Unable to connect to the Colts API."
      end
    end
  end
end
