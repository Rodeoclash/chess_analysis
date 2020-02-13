require 'test/unit'

require_relative '../../../lib/scoutfish/create_database_results'

class Scoutfish
  class CreateDatabaseResultsTest < Test::Unit::TestCase
    def setup
      data = {}
      @create_results = Scoutfish::CreateDatabaseResults.new(data)
    end

    def test_initialize
      assert(@create_results.kind_of?(Scoutfish::CreateDatabaseResults))
    end
  end
end
