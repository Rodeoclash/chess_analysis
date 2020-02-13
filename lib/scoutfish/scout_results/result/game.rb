class Scoutfish
  class ScoutResults
    class Result
      class Game
        DATUM = /\[(.+)\ "(.+)"\]/

        def initialize(pgn_file, ofs)
          @data = {}

          pgn_file.read_game_at(ofs).each_line do |line|
            results = line.scan(DATUM)[0]
            if results
              key = results[0]
              value = results[1]
              @data[key] = value.nil? || value == '?' ? nil : value
            end
          end
        end

        def white_win?
          @data['Result'] == "1-0"
        end

        def black_win?
          @data['Result'] == "0-1"
        end

        def draw
          @data['Result'] == "1/2-1/2"
        end

        def white_elo
          @data['WhiteElo']&.to_i
        end

        def black_elo
          @data['BlackElo']&.to_i
        end

        def elo_difference
          if white_elo.nil? || black_elo.nil?
            nil
          else
            (white_elo - black_elo).abs
          end
        end
      end
    end
  end
end
