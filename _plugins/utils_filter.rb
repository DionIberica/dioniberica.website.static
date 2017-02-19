module Jekyll
  module UtilsFilter
    def in_groups_of(input, size)
      input.each_slice(size).to_a
    end
  end
end

Liquid::Template.register_filter(Jekyll::UtilsFilter)
