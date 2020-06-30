# Require core library
require "middleman-core"
require "fileutils"

# Extension namespace
module Middleman
  # Creates .tex files from source files in `sources` directory
  class TexCreator < Middleman::Extension
    option :my_option, "default", "An example option"

    def initialize(app, options_hash = {}, &block)
      # Call super to build options from the options_hash
      super
      app.config.extensions_with_layout << ".tex" unless app.config.extensions_with_layout.include?(".tex")

      # Require libraries only when activated
      require "create-tex/kramdown_tex"
      ::Tilt.prefer(::Middleman::Renderers::KramdownTexTemplate, "md_tex")

      # set up your extension
      # puts options.my_option
    end

    def source_files
      app.files.by_type(:source).files
    end

    def after_configuration
      source_files.select { |file| file.relative_path.to_s =~ /html\.md\.erb/ }.each do |file|
        target = file.full_path.to_s.gsub("html.md.erb", "tex.md_tex.erb")
        temporary_source = Pathname.new(target)
        FileUtils.copy_file(file.full_path, temporary_source) unless temporary_source.exist?
      end
    end

    def before_build
      app.sitemap.resources
         .select { |recurso| recurso.file_descriptor.full_path.to_s =~ /md_tex/ }
         .each do |recurso|
        recurso.add_metadata options: { layout: recurso.metadata[:page][:tex_layout] }
      end
    end

    def after_build
      app.sitemap.resources
         .map { |recurso| recurso.file_descriptor.full_path }
         .select { |path| path.to_s =~ /tex\.md_tex\.erb/ }.to_set
         .each(&:delete)
    end

    def tex_resource_without_layout?(resource)
      resource.file_descriptor.full_path.to_s =~ /tex\.md_tex\.erb/ && resource.metadata[:page][:tex_layout].nil?
    end

    # A Sitemap Manipulator
    def manipulate_resource_list(resources)
      resources.reject { |resource| tex_resource_without_layout?(resource) }
    end

    # helpers do
    #   def a_helper
    #   end
    # end
  end
end
