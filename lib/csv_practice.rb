require 'csv'
require 'awesome_print'

def get_all_olympic_athletes(filename)
  all_olympians = []
  CSV.read(filename, headers:true).each do |athlete|
    sample_olympian = {
        "ID" => 0,
        "Name" => 0,
        "Height" => 0,
        "Team" => 0,
        "Year" => 0,
        "City" => 0,
        "Sport" => 0,
        "Event" => 0,
        "Medal" => 0
    }
    athlete.each do |key, value|
      if sample_olympian.has_key?(key)
        sample_olympian[key] = value
      end
    end
    all_olympians << sample_olympian
  end
  return all_olympians
end

def total_medals_per_team(olympic_data)
  medals_per_team = {}
  medal_winners = olympic_data.filter { |athlete| athlete["Medal"] != "NA"}
  medal_winners.each do |athlete|
    if !medals_per_team.has_key?(athlete["Team"])
      medals_per_team[athlete["Team"]] = 1
    else
      medals_per_team[athlete["Team"]] += 1
    end
  end
  return medals_per_team
end

def get_all_gold_medalists(olympic_data)
  gold_medalists = olympic_data.filter { |athlete| athlete["Medal"] == "Gold" }
  return gold_medalists
end

def team_with_most_medals(medals_per_team)
  highest_team_with_count = { "Team" => nil, "Count" => nil }
  top_team = medals_per_team.max_by { |team, count| count}
  highest_team_with_count["Team"] = top_team[0]
  highest_team_with_count["Count"] = top_team[1]
  return highest_team_with_count
end