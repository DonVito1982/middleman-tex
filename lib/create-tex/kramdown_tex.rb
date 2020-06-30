module Middleman
  module Renderers
    # Tilt template for converting from MarkDown to LaTeX
    class KramdownTexTemplate < ::Tilt::KramdownTemplate
      def evaluate(scope, _locals, &block)
        @output ||= @engine.to_latex
      end
    end
  end
end
