require_relative './lib/pgn/file'
require_relative './lib/scoutfish'

pgn_file_path = ARGV[0]

puts "Enter query:"
query = JSON.parse($stdin.gets.chomp)

# Execution
logger = Logger.new(STDOUT)
pgn_file = PGN::File.new(pgn_file_path)
scoutfish = Scoutfish.new(pgn_file)

unless scoutfish.database_exists?
  logger.info "Database not found, creating..."
  scoutfish.create_database
end

logger.info "Starting search..."
scout_results = scoutfish.scout(query)

logger.info "Found #{scout_results.matches.count} matches containing fen: #{query}"

logger.info "Filtering..."
filtered_scout_results = scout_results
  .reject {|match|
    match.game.white_elo < 1800 || match.game.black_elo < 1800
  }
  .filter {|match|
    match.ply.first <= 10
  }

logger.info "#{filtered_scout_results.count} results after filtering"

sample_game_1 = filtered_scout_results.sample
sample_game_2 = filtered_scout_results.sample

logger.info "Sample game 1: #{sample_game_1.inspect}/#{sample_game_1.game.inspect}"
logger.info "Sample game 2: #{sample_game_2.inspect}/#{sample_game_2.game.inspect}"

logger.info "Crunching data..."
win_results = filtered_scout_results
  .reduce([0,0,0]) {|sums, match|
    if match.game.white_win?
      [sums[0] + 1, sums[1], sums[2]]
    elsif match.game.black_win?
      [sums[0], sums[1] + 1, sums[2]]
    else
      [sums[0], sums[1], sums[2] + 1]
    end
  }

p "White wins: #{(win_results[0].to_f / filtered_scout_results.count.to_f).round(2) * 100}%"
p "Black wins: #{(win_results[1].to_f / filtered_scout_results.count.to_f).round(2) * 100}%"
p "Draws: #{(win_results[2].to_f / filtered_scout_results.count.to_f).round(2) * 100}%"
