module Cycromatic
  class Result
    attr_reader :filepath
    attr_reader :method_name
    attr_reader :first_line
    attr_reader :last_line
    attr_reader :complexity

    def initialize(filepath:, method_name: nil, node:, complexity:)
      @filepath = filepath
      @method_name = method_name || node.children.find {|child| child.is_a?(Symbol)}.to_s
      @first_line = node.loc.first_line
      @last_line = node.loc.last_line
      @complexity = complexity
    end
  end
end
