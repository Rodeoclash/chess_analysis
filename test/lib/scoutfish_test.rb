require 'test/unit'

require_relative '../../lib/pgn/file'
require_relative '../../lib/scoutfish'
require_relative '../../lib/scoutfish/create_database_results'

class ScoutfishTest < Test::Unit::TestCase
  def setup
    @pgn_file = PGN::File.new(
      ::File.join(
        ::File.dirname(::File.absolute_path(__FILE__)),
        '../',
        'fixtures',
        'games.pgn'
      )
    )

    @database = Scoutfish.new(@pgn_file)

    File.delete(@database.path) if File.exists?(@database.path)
  end

  def teardown
    @database.close
  end

  def test_initialize
    assert(@database.kind_of?(Scoutfish))
  end

  def test_path
    assert_equal('/usr/src/app/test/lib/../fixtures/games.scout', @database.path)
  end

  def test_database_exists?
    assert_equal(false, @database.database_exists?)
  end

  def test_create_database
    assert_equal(false, @database.database_exists?)
    assert(@database.create_database.kind_of?(Scoutfish::CreateDatabaseResults))
    assert_equal(true, @database.database_exists?)
  end

  def test_scout
    @database.create_database

    query = {
      'sub-fen' => '8/8/8/8/3P4/2P5/PP3PPP/8'
    }

    response = @database.scout(query)
  end
end
