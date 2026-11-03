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

  STAT_CATEGORIES = {
    "Passing" => %w[pass_att comp comp_pct pass_yards pass_td pass_long sacked int qb_rtng],
    "Rushing" => %w[rush_att rush_yds rush_ypc rush_long rush_td],
    "Receiving" => %w[rec rec_yds rec_ypc rec_long rec_td],
    "Defense" => %w[tackles solo_tackles assist def_sacks def_fumble def_int def_td],
    "Kicking" => %w[fg_1to19 fg_20to29 fg_30to39 fg_40to49 fg_50to59 fg_60Plus],
    "Punting" => %w[punt punt_yards punt_in20 pung_avg punt_lng],
    "Kick Returns" => %w[kr_ret kr_fc kr_yds kr_yds_ret kr_lng kr_td],
    "Punt Returns" => %w[pr_ret pr_fc pr_yds pr_yds_ret pr_lng pr_td]
  }.freeze

  def stat_keys_order(position, stat_hash)
    available_keys = stat_hash.except("year", "number", "position", "exp", "status").keys
    grouped = {}

    STAT_CATEGORIES.each do |category_name, keys|
      matching_keys = keys & available_keys
      grouped[category_name] = matching_keys if matching_keys.any?
    end

    grouped
  end

  STAT_KEY_LABELS = {
    # Passing
    "pass_att" => "ATT",
    "comp" => "COMP",
    "comp_pct" => "COMP%",
    "pass_yards" => "YDS",
    "pass_long" => "LNG",
    "pass_td" => "TD",
    "sacked" => "SACK",
    "int" => "INT",
    "qb_rtng" => "RTNG",

    # Rushing
    "rush_att" => "ATT",
    "rush_yds" => "YDS",
    "rush_ypc" => "YPC",
    "rush_long" => "LNG",
    "rush_td" => "TD",

    # Receiving
    "rec" => "REC",
    "rec_yds" => "YDS",
    "rec_ypc" => "YPC",
    "rec_long" => "LNG",
    "rec_td" => "TD",

    # Defense
    "tackles" => "COMB",
    "solo_tackles" => "SOLO",
    "assist" => "AST",
    "def_sacks" => "SACK",
    "def_fumble" => "FF",
    "def_int" => "INT",
    "def_td" => "TD",

    # Kicking
    "fg_1to19" => "1-19",
    "fg_20to29" => "20-29",
    "fg_30to39" => "30-39",
    "fg_40to49" => "40-49",
    "fg_50to59" => "50-59",
    "fg_60Plus" => "60+",

    # Punting
    "punt" => "PUNTS",
    "punt_yards" => "YDS",
    "punt_in20" => "IN20",
    "pung_avg" => "AVG",
    "punt_lng" => "LNG",

    # Kick Returns
    "kr_ret" => "RET",
    "kr_fc" => "FC",
    "kr_yds" => "YDS",
    "kr_yds_ret" => "AVG",
    "kr_lng" => "LNG",
    "kr_td" => "TD",

    # Punt Returns
    "pr_ret" => "RET",
    "pr_fc" => "FC",
    "pr_yds" => "YDS",
    "pr_yds_ret" => "AVG",
    "pr_lng" => "FC",
    "pr_td" => "TD"
  }

  def display_stat_labels(key)
    STAT_KEY_LABELS.fetch(key.to_s) do
      key.to_s.tr("_", " ").titleize
    end
  end
end
