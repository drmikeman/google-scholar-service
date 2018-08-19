require 'grape'

class Papers
  PAPERS = [
    {
      profile: 'michal',
      title: 'On some end-user programming constructs and their understandability',
      authors: 'Mackowiak, Nawrocki, Ochodek',
      journal: 'JSS',
      year: 2018
    },
    {
      profile: 'jurek',
      title: 'On some end-user programming constructs and their understandability',
      authors: 'Mackowiak, Nawrocki, Ochodek',
      journal: 'JSS',
      year: 2018
    },
    {
      profile: 'mirek',
      title: 'On some end-user programming constructs and their understandability',
      authors: 'Mackowiak, Nawrocki, Ochodek',
      journal: 'JSS',
      year: 2018
    },
    {
      profile: 'sylwia',
      title: 'Perceived Importance of Agile Requirements Engineering Practices',
      authors: 'Kopczynska, Ochodek',
      journal: 'JSS',
      year: 2018
    },
    {
      profile: 'mirek',
      title: 'Perceived Importance of Agile Requirements Engineering Practices',
      authors: 'Kopczynska, Ochodek',
      journal: 'JSS',
      year: 2018
    },
    {
      profile: 'sylwia',
      title: 'An Empirical Study on Catalog of Non-functional Requirement Templates: Usefulness and Maintenance Issues',
      authors: 'Kopczynska, Nawrocki, Ochodek',
      year: 2018
    },
    {
      profile: 'jurek',
      title: 'An Empirical Study on Catalog of Non-functional Requirement Templates: Usefulness and Maintenance Issues',
      authors: 'Kopczynska, Nawrocki, Ochodek',
      year: 2018
    },
    {
      profile: 'mirek',
      title: 'An Empirical Study on Catalog of Non-functional Requirement Templates: Usefulness and Maintenance Issues',
      authors: 'Kopczynska, Nawrocki, Ochodek',
      year: 2018
    }
  ].freeze

  def search(profile, from, to)
    PAPERS.select { |paper| paper[:profile] == profile && paper[:year] >= from && paper[:year] <= to }
  end
end

class Points
  POINTS = { 2018 => { 'JSS' => 35, 'IST' => 35 } }.freeze

  def search(journal, year)
    POINTS.dig(year, journal) || -1
  end
end

class API < Grape::API
  format :json
  prefix :api

  desc 'Get the papers for a given author in a given year range'
  params do
    requires :profile, type: String
    requires :from, type: Integer
    requires :to, type: Integer
  end
  get :papers do
    Papers.new.search(params[:profile], params[:from], params[:to])
  end

  desc 'Get the points for a given journal in a given year'
  params do
    requires :journal, type: String
    requires :year, type: Integer
  end
  get :points do
    Points.new.search(params[:journal], params[:year])
  end
end

run API
