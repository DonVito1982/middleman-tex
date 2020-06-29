module Middleman
  module Renderers
    class KramdownTexTemplate < ::Tilt::KramdownTemplate
      def evaluate(scope, locals, &block)
        #puts @options[:context].class
        @output ||= @engine.to_latex
      end
    end
  end
end

