require 'optparse'
require 'pathname'
require 'byebug'

module Cycromatic
  class CLI
    def self.start(args = ARGV)
      self.new(args).run
    end

    def initialize(args)
      @paths = args.map { |arg| Pathname(arg) }
      @options = {
        output_filename: nil,
        open_after: false
      }

      OptionParser.new do |opts|
        opts.on("-o OUTPUT") { |o| @options[:output_filename] = o }
        opts.on("--open") { @options[:open_after] = true }
      end.parse!(args)
    end

    def run
      writer = WriterFactory.create(filename: @options[:output_filename])

      FileEnumerator.new(paths: @paths).each do |path|
        begin
          Calculator.new.calculate(path) { |result| writer.write(result) }
        rescue => ex
          writer.error(path: path, exception: ex)
        end
      end

      writer.close
      system("open #{@options[:output_filename]}") if @options[:open_after]
    end
  end
end
