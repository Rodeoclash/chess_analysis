require 'test/unit'

require_relative '../../../../lib/scoutfish/scout_results'
require_relative '../../../../lib/scoutfish/scout_results/result'

class Scoutfish
  class ScoutResults
    class ResultTest < Test::Unit::TestCase
      def setup
        @match = Scoutfish::ScoutResults::Result.new(nil, {
          'ofs' => 'ofs',
          'ply' => 'ply',
        })
      end

      def test_initialize
        assert(@match.kind_of?(Scoutfish::ScoutResults::Result))
      end

      def test_ofs
        assert_equal(@match.ofs, 'ofs')
      end

      def test_ply
        assert_equal(@match.ply, 'ply')
      end
    end
  end
end
