require "middleman-core"

Middleman::Extensions.register :create_tex do
  require "create-tex/extension"
  Middleman::TexCreator
end
