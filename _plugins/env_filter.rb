module Jekyll
  module EnvFilter
    def env(input)
      ENV[input]
    end
  end
end

Liquid::Template.register_filter(Jekyll::EnvFilter)
