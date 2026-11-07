class SeasonsController < ApplicationController
  def index
    @result = ColtsNation::ApiClient.fetch_seasons

    if @result&.success?
      raw_schedule = @result.seasons || @result["seasons"] || []

      schedule = raw_schedule.uniq do |game|
        [ game["year"] || game[:year], game["week"] || game[:week] ]
      end

      @seasons = schedule.group_by { |game| game["year"] || game[:year] }
        .sort_by { |year, _| year.to_i }
        .reverse
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
