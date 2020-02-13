require_relative './result/game'

class Scoutfish
  class ScoutResults
    class Result
      def initialize(pgn_file, result)
        @pgn_file = pgn_file
        @result = result
      end

      def ofs
        @result['ofs']
      end

      def ply
        @result['ply']
      end

      def game
        Game.new(@pgn_file, ofs)
      end
    end
  end
end
