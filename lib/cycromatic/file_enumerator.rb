module Cycromatic
  class FileEnumerator
    attr_reader :paths

    def initialize(paths:)
      @paths = paths
    end

    def each(&block)
      paths.each do |path|
        case
        when path.file? && ruby_file?(path)
          yield path
        when path.directory?
          enumerate_files_in_dir(path, &block)
        end
      end
    end

    private

    def enumerate_files_in_dir(path, &block)
      return if path.basename.to_s =~ /\A\.[^\.]+/  # skip hidden path

      case
      when path.directory?
        path.children.each { |child| enumerate_files_in_dir(child, &block) }
      when path.file? && ruby_file?(path)
        yield path
      end
    end

    def ruby_file?(path)
      path.extname == ".rb"
    end
  end
end
