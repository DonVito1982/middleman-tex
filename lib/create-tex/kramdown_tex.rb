module Middleman
  module Renderers
    class KramdownTexTemplate < ::Tilt::KramdownTemplate
      def evaluate(scope, locals, &block)
        @output ||= @engine.to_latex
      end
    end
  end
end

