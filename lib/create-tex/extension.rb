# Require core library
require 'middleman-core'
require 'fileutils'

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
      # puts "after configuration. Recursos #{app.sitemap.resources.to_a.length}"
      app.sitemap.resources
        .map { |recurso| recurso.file_descriptor.full_path }
        .select {|path| path.to_s =~ /html\.md\.erb/ }
        .each do |path|
        target = path.to_s.gsub("html.md.erb", "tex.md_tex.erb")
        temporary_source = Pathname.new(target)
        FileUtils.copy_file(path, temporary_source)
      end
    end
    
    def before_build
      # raise "before build"
      # puts "before build. Recursos: #{app.sitemap.resources.to_a.length}"
    end
    
    def after_build
      app.sitemap.resources
        .map { |recurso| recurso.file_descriptor.full_path }
        .select { |path| path.to_s =~ /tex\.md_tex\.erb/ }
        .each { |path| path.delete }
    end
    
    def ready
      # puts "ready. Recursos: #{app.sitemap.resources.to_a.length}"
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

