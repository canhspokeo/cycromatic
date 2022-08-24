module Cycromatic
  class TextWriter
    attr_reader :io

    def initialize(io:)
      @io = io
    end

    def close
      # Do nothing
    end

    def error(path:, exception:)
      io.puts "#{path}\t(error)"
      io.puts exception
    end

    def write(result)
      io.puts "#{result.filepath}\t#{result.method_name}:#{result.first_line}-#{result.last_line}\t#{result.complexity}"
    end
  end
end
