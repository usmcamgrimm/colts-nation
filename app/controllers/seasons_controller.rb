class SeasonsController < ApplicationController
  def index
    @result = ColtsNation::ApiClient.fetch_seasons

    if @result&.success?
      @seasons = @result.seasons
    else
      @seasons = []
      error_type = @result&.error || :network_error

      flash[:alert] = if error_type == :upstream_error
        "Unable to process your request. Please try again."
      else
        "Unable to connect to the Colts API."
      end
    end
  end
end
