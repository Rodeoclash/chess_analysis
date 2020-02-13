require 'test/unit'

require_relative '../../../lib/scoutfish/parser'

class Scoutfish
  class ParserTest < Test::Unit::TestCase
    def setup
      path = File.join(
        ::File.dirname(::File.absolute_path(__FILE__)),
        '../',
        '../',
        'fixtures',
        'example.json'
      )

      source = File.open(path)

      @parser = Scoutfish::Parser.new(source)
    end

    def test_initialize
      assert(@parser.kind_of?(Scoutfish::Parser))
    end

    def test_response
      assert_equal(@parser.response, {
        'test' => 'value',
      })
    end
  end
end
