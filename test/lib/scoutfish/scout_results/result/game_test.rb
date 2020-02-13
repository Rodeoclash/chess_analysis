require 'test/unit'

require_relative '../../../../../lib/scoutfish/scout_results/result/game'
require_relative '../../../../../lib/pgn/file'

class Scoutfish
  class ScoutResults
    class Result
      class GameTest < Test::Unit::TestCase
        def setup
          pgn_file = PGN::File.new(
            ::File.join(
              ::File.dirname(::File.absolute_path(__FILE__)),
              '../',
              '../',
              '../',
              '../',
              'fixtures',
              'games.pgn'
            )
          )

          @game = Scoutfish::ScoutResults::Result::Game.new(pgn_file, 666)
        end

        def test_initialize
          assert(@game.kind_of?(Scoutfish::ScoutResults::Result::Game))
        end

        def test_black_win
          assert_equal(@game.black_win?, true)
        end

        def test_white_win
          assert_equal(@game.white_win?, false)
        end

        def test_draw
          assert_equal(@game.draw, false)
        end

        def test_white_elo
          assert_equal(@game.white_elo, nil)
        end

        def test_black_elo
          assert_equal(@game.black_elo, nil)
        end

        def test_elo
          assert_equal(@game.elo_difference, nil)
        end
      end
    end
  end
end
