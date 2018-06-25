# frozen_string_literal: true

collection @matches, object_root: false
cache ['sum', @matches], expires_in: @cache_time
attributes :venue, :location, :status, :time, :fifa_id
node :home_team_country do |match|
  match.home_team&.country
end
node :away_team_country do |match|
  match.away_team&.country
end
node :datetime do |match|
  match.datetime&.utc&.iso8601
end
node :winner do |match|
  if match.winner
    match.winner.country
  elsif match.draw
    'Draw'
  end
end
node :winner_code do |match|
  if match.winner
    match.winner.fifa_code
  elsif match.draw
    'Draw'
  end
end
node :home_team do |match|
  if match.home_team
    {
      country: match.home_team.country,
      code: match.home_team.fifa_code,
      goals: match.home_team_score
    }
  else
    {
      country: 'To Be Determined',
      code: 'TBD',
      team_tbd: match.home_team_tbd
    }
  end
end
node :away_team do |match|
  if match.away_team
    {
      country: match.away_team.country,
      code: match.away_team.fifa_code,
      goals: match.away_team_score
    }
  else
    {
      country: 'To Be Determined',
      code: 'TBD',
      team_tbd: match.away_team_tbd
    }
  end
end
node :last_event_update_at do |match|
  match.last_event_update_at&.utc&.iso8601
end
node :last_score_update_at do |match|
  match.last_score_update_at&.utc&.iso8601
end
