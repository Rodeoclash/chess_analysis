require 'json'

require_relative './scout_results/result'

class Scoutfish
  class ScoutResults
    include Enumerable

    def initialize(pgn_file, results)
      @pgn_file = pgn_file
      @results = results
    end

    def matches
      @results['matches']
    end

    def moves
      @results['moves']
    end

    def each(&block)
      matches.each do |match|
        block.call(Result.new(@pgn_file, match))
      end
    end
  end
end
