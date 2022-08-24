require 'forwardable'

module Cycromatic
  class HtmlWriter
    extend Forwardable
    def_delegators :@json_writer, :write, :error

    attr_reader :io

    def initialize(io:)
      @io = io
      @json_writer = JsonWriter.new(io: nil)
    end

    def close
      styles = File.readlines(File.join(__dir__, 'html_styles.css'))
                   .delete_if { |line| line.strip.empty? }
                   .join()
      html = File.readlines(File.join(__dir__, 'html_template.html'))
                 .map do |line|
                    case line.strip
                    when '{{styles}}'
                      styles
                    when 'const initialData = {};'
                      line.gsub('{}', @json_writer.json)
                    else
                      line
                    end
      end
      @io.puts html
      @io.close if @io.is_a?(File)
    end
  end
end
