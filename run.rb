require_relative './lib/pgn/file'
require_relative './lib/scoutfish'

# Config
sub_fen = '8/4pp2/3p2p1/8/2P1P3/8/6P1/8'

pgn_file_path = File.join(
  File.dirname(File.absolute_path(__FILE__)),
  'pgn',
  'lichess_db_standard_rated_2014-07.pgn'
)

# Execution
logger = Logger.new(STDOUT)
pgn_file = PGN::File.new(pgn_file_path)
scoutfish = Scoutfish.new(pgn_file)

unless scoutfish.database_exists?
  logger.info "Database not found, creating..."
  scoutfish.create_database
end

logger.info "Starting search..."
scout_results = scoutfish.scout({
  'sub-fen' => sub_fen
})

logger.info "Found #{scout_results.matches.count} matches containing fen: #{sub_fen}"

logger.info "Filtering..."
filtered_scout_results = scout_results
  .reject {|match|
    match.game.white_elo < 1800 || match.game.black_elo < 1800
  }

logger.info "#{filtered_scout_results.count} results after filtering"

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
