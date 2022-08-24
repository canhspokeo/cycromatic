module Cycromatic
  class WriterFactory
    def self.create(filename: nil)
      io = filename ? File.new(filename, 'w') : $stdout
      format = filename ? File.extname(filename) : 'unknown'
      case format.downcase
      when '.json'
        JsonWriter.new(io: io)
      when '.html'
        HtmlWriter.new(io: io)
      else
        TextWriter.new(io: io)
      end
    end

  end
end
