module Cycromatic
class JsonWriter
    attr_reader :io

    def initialize(io:)
      @io = io
      @results = {}
    end

    def close
      @io.puts json
      @io.close if @io.is_a?(File)
    end

    def error(path:, exception:)
      puts "#{path}\t(error)"
      puts exception
    end

    def write(result)
      @results[result.filepath] = { results: [] } unless @results[result.filepath]
      @results[result.filepath][:results] << {
        method: result.method_name,
        firstLine: result.first_line,
        lastLine: result.last_line,
        complexity: result.complexity
      }
    end

    def json
      @results.to_json
    end
  end
end
