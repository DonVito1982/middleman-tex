# Require core library
require 'middleman-core'

# Extension namespace
module Middleman
  class TexCreator < Middleman::Extension
    option :my_option, 'default', 'An example option'
    
    def initialize(app, options_hash={}, &block)
      # Call super to build options from the options_hash
      super
      
      # Require libraries only when activated
      # require 'necessary/library'

      # set up your extension
      # puts options.my_option
    end

    def after_configuration
      # Do something
      # raise "after config"
      puts "after configuration. Recursos #{app.sitemap.resources.to_a.length}"
    end
    
    def before_build
      # raise "before build"
      puts "before build. Recursos: #{app.sitemap.resources.to_a.length}"
    end
    
    def after_build
      puts "after build. Recursos: #{app.sitemap.resources.to_a.length}"
    end
    
    def ready
      puts "ready. Recursos: #{app.sitemap.resources.to_a.length}"
      #app.sitemap.resources.each do |resource|
      #  puts resource.path
      #  puts resource.file_descriptor.full_path
      #end
    end
    
    # A Sitemap Manipulator
    # def manipulate_resource_list(resources)
    # end

    # helpers do
    #   def a_helper
    #   end
    # end
  end

end

