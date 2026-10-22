module PlayersHelper
  def player_status(status)
    status_headings = {
      "Active" => "Active Roster",
      "PS" => "Practice Squad",
      "IR" => "Reserve / Injured",
      "NFI" => "Active / Non-Football Injury",
      "IRDR" => "Reserve (Designated for Return)",
      "PSI" => "Practice Squad - Injured",
      "RF" => "Reserve / Future",
      "Suspended - Team" => "Suspended By Team",
      "Suspended - Commissioner" => "Suspended By Commissioner",
      "Exempt" => "Exempt",
      "UDP" => "Unsigned Draft Picks"
    }
    status_headings[status] || status
  end
end
