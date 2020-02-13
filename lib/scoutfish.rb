require 'logger'
require 'pty'

require_relative './scoutfish/parser'
require_relative './scoutfish/create_database_results'
require_relative './scoutfish/scout_results'

class Scoutfish
  def initialize(pgn_file)
    @pgn_file = pgn_file
    @logger = Logger.new(STDOUT)
    @master, @slave = PTY.open
    @read, @write = IO.pipe
    @pid = spawn('scoutfish', in: @read, out: @slave)
    @parser = Scoutfish::Parser.new(@master)
    @read.close
    @slave.close
  end

  def path
    path = @pgn_file.path

    File.join(
      File.dirname(path),
      "#{File.basename(path, '.pgn')}.scout"
    )
  end

  def database_exists?
    File.exist?(path)
  end

  def create_database
    cmd = "make #{@pgn_file.path}"
    @logger.info("Running: #{cmd}")

    @write.puts(cmd)

    CreateDatabaseResults.new(@parser.response)
  end

  def scout(query)
    cmd = "scout #{path} #{query.to_json}"
    @logger.info("Running: #{cmd}")

    @write.puts(cmd)

    ScoutResults.new(@pgn_file, @parser.response)
  end

  def close
    @master.close
    @write.close
  end
end
