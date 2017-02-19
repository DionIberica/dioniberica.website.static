require 'i18n'

LOCALE = :en # set your locale

# Create folder "_locales" and put some locale file from https://github.com/svenfuchs/rails-i18n/tree/master/rails/locale
module Jekyll
  module I18nFilter
    # Example:
    #   {{ post.date | localize: "%d.%m.%Y" }}
    #   {{ post.date | localize: ":short" }}
    def localize(input, format=nil)
      load_translations
      format = (format =~ /^:(\w+)/) ? $1.to_sym : format
      I18n.l input, :format => format
    end

    def translate(input, field=nil)
      locale = @context.registers[:page]['locale']

      if field
        input["#{field}_#{locale}"]
      else
        load_translations
        I18n.t input, locale: locale
      end
    end

    def section(name)
      site = @context.registers[:site]
      locale = @context.registers[:page]['locale']

      site.pages.select do |page|
        page.data['section'] == name and page.data['locale'] == locale
      end.first
    end

    def load_translations
      if I18n.backend.send(:translations).empty?
        I18n.backend.load_translations Dir[File.join(File.dirname(__FILE__),'../_locales/*.yml')]
        I18n.locale = LOCALE
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::I18nFilter)
