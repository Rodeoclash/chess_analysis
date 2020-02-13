require 'yajl'

class Scoutfish
  class Parser
    def initialize(source)
      @source = source
      @parser = Yajl::Parser.new
      @parser.on_parse_complete = method(:object_parsed)
      @completed = false
    end

    def response
      @completed = false

      loop do
        @parser << @source.read(1)
        break if @completed == true
      end

      @completed = false
      @response
    end

    private
    def object_parsed(obj)
      @completed = true
      @response = obj
    end
  end
end
