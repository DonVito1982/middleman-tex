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
      app.config.extensions_with_layout << '.tex' unless app.config.extensions_with_layout.include?('.tex')
      
      # Require libraries only when activated
      require 'create-tex/kramdown_tex'
      ::Tilt.prefer(::Middleman::Renderers::KramdownTexTemplate, 'md_tex')

      # set up your extension
      # puts options.my_option
    end

    def after_configuration
      # Do something
      # raise "after config"
      puts "After configuration"
      puts "configurando #{app.files.by_type(:source).files.length} archivos"
      app.files.by_type(:source).files
        .select { |file| file.relative_path.to_s =~ /html\.md\.erb/ }
        .each do |file|
        target = file.full_path.to_s.gsub("html.md.erb", "tex.md_tex.erb")
        temporary_source = Pathname.new(target)
        FileUtils.copy_file(file.full_path, temporary_source) unless temporary_source.exist?
      end
      #app.sitemap.resources
      #  .map { |recurso| recurso.file_descriptor.full_path }
      #  .select {|path| path.to_s =~ /html\.md\.erb/ }
      #  .each do |path|
      #  target = path.to_s.gsub("html.md.erb", "tex.md_tex.erb")
      #  temporary_source = Pathname.new(target)
      #  FileUtils.copy_file(path, temporary_source)
      #end
    end
    
    def before_build
      # raise "before build"
      puts "before build. Recursos: #{app.sitemap.resources.to_a.length}"
      # app.sitemap.resources.each { |recurso| puts recurso.destination_path }
      app.sitemap.resources
        .select { |recurso| recurso.file_descriptor.full_path.to_s =~ /md_tex/ }
        .each do |recurso|
        recurso.add_metadata options: { layout: recurso.metadata[:page][:tex_layout] }
        puts "Destino: #{recurso.destination_path}. MD: #{recurso.metadata[:options]}"
      end
    end
    
    def after_build
      #puts "Clase de recursos #{app.sitemap.resources.class}"
      app.sitemap.resources
        .map { |recurso| recurso.file_descriptor.full_path }
        .select { |path| path.to_s =~ /tex\.md_tex\.erb/ }.to_set
        .each { |path| path.delete }
    end
 
    def ready
      #app.sitemap.resources.each do |resource|
      #  puts resource.path
      #  puts resource.file_descriptor.full_path
      #end
    end
    
    # A Sitemap Manipulator
    def manipulate_resource_list(resources)
      puts "Manipulando recursos. Son #{app.files.by_type(:source).files.length}"
      #app.files.by_type(:source).files.each do |file|
      #  puts "ruta del archivo #{file.relative_path}"
      #end
      #new_resources.each do |resource| 
      #  resource.add_metadata options: { layout: resource.metadata[:page][:tex_layout] }
      #  puts "El layout del nuevo recurso es #{resource.metadata[:page][:tex_layout]}"
      #end
      #  .select { |recurso| recurso.metadata[:page].key?(:tex_layout) }
      #  .map do |recurso| 
      #  path = recurso.file_descriptor.full_path
      #  target = path.to_s.gsub("html.md.erb", "tex.md_tex.erb")
      #  temporary_source = Pathname.new(target)
      #  FileUtils.copy_file(path, temporary_source)
      #end
      resources.reject { |resource| resource.file_descriptor.full_path.to_s =~ /tex\.md_tex\.erb/ && resource.metadata[:page][:tex_layout].nil? }
    end

    # helpers do
    #   def a_helper
    #   end
    # end
  end

end

