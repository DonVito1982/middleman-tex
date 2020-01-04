require "middleman-core"

Middleman::Extensions.register :create-tex do
  require "my-extension/extension"
  MyExtension
end
