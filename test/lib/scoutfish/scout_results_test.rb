require 'test/unit'

require_relative '../../../lib/scoutfish/scout_results'
require_relative '../../../lib/scoutfish/scout_results/result'

class Scoutfish
  class ScoutResultsTest < Test::Unit::TestCase
    def setup
      data = {
        'matches' => [{}],
        'moves' => 'moves',
      }
      @scout_results = Scoutfish::ScoutResults.new(nil, data)
    end

    def test_initialize_with_valid_results
      assert(@scout_results.kind_of?(Scoutfish::ScoutResults))
    end

    def test_matches
      assert_equal(@scout_results.matches, [{}])
    end

    def test_moves
      assert_equal(@scout_results.moves, 'moves')
    end

    def test_count
      assert_equal(@scout_results.count, 1)
    end

    def test_results
      assert(@scout_results.first.kind_of?(ScoutResults::Result))
    end
  end
end
