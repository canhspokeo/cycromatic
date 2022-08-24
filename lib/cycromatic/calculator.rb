module Cycromatic
  class Calculator

    def calculate(path, &block)
      return unless path
      @filepath = path.to_s
      node = Parser::CurrentRuby.parse(path.read, @filepath)
      complexity = calculate_node(node, &block)
      yield Result.new(filepath: @filepath, method_name: "[toplevel]", node: node, complexity: complexity + 1)
    end

    private

    COMPLEX_NODE_TYPES = Set.new([:if, :while, :while_post, :when, :resbody, :csend, :for,
                                  :and, :or,
                                  :optarg, :kwoptarg])

    def calculate_def(node, &block)
      case node.type
      when :def
        args = node.children[1]
        body = node.children[2]
      when :defs
        args = node.children[2]
        body = node.children[3]
      end

      complexity = 1
      complexity += calculate_node(args, &block)
      complexity += calculate_node(body, &block) if body

      yield Result.new(filepath: @filepath, node: node, complexity: complexity)
    end

    def calculate_node(node, &block)
      complexity = 0
      case node.type
      when :def
        calculate_def(node, &block)
        return 0
      when :defs
        calculate_def(node, &block)
        return calculate_node(node.children[0], &block)
      when :case
        complexity = 1 if node.children.last
      when :rescue
        complexity = 1 if node.children.last
      else
        complexity = 1 if COMPLEX_NODE_TYPES.include?(node.type)
      end

      children_complexities = node.children.flat_map do |child|
        child.is_a?(Parser::AST::Node) ? calculate_node(child, &block) : 0
      end

      complexity + children_complexities.reduce(0, :+)
    end
  end
end
