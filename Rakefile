require 'open-uri'
require 'csv'
require 'yaml'

I18N_FILE = "https://docs.google.com/spreadsheets/d/16LcVmLS3Da94C4-KuX_ijAh8K0XUgkgQRwOP-5EIM2Y/pub?gid=0&single=true&output=csv"
DATA_FILES = {
  faq:            'https://docs.google.com/spreadsheets/d/16LcVmLS3Da94C4-KuX_ijAh8K0XUgkgQRwOP-5EIM2Y/pub?gid=1539468359&single=true&output=csv',
  testimonials:   'https://docs.google.com/spreadsheets/d/16LcVmLS3Da94C4-KuX_ijAh8K0XUgkgQRwOP-5EIM2Y/pub?gid=1558132726&single=true&output=csv',
  recomendations: 'https://docs.google.com/spreadsheets/d/16LcVmLS3Da94C4-KuX_ijAh8K0XUgkgQRwOP-5EIM2Y/pub?gid=1957447366&single=true&output=csv',
  steps:          'https://docs.google.com/spreadsheets/d/16LcVmLS3Da94C4-KuX_ijAh8K0XUgkgQRwOP-5EIM2Y/pub?gid=1268967111&single=true&output=csv',
  benefits:       'https://docs.google.com/spreadsheets/d/16LcVmLS3Da94C4-KuX_ijAh8K0XUgkgQRwOP-5EIM2Y/pub?gid=1895306404&single=true&output=csv',
}

task :i18n do
  puts "Downloading i18n files..."

  open(I18N_FILE) do |file|
    csv2yaml(file)
  end
end

task :data do
  puts "Downloading data files..."
  DATA_FILES.each do |key, value|
    download(value, "_data/#{key}.csv")
  end
end

def download(url, path)
  open(url) {|f|
    File.open(path,"wb") do |file|
      file.puts f.read.gsub(/\r\n/, "\n")
    end
  }
end

def csv2yaml(file)
  data = CSV.read(file, :headers => true)

  headers = data.headers
  master = headers.slice!(0)
  translations = data.map(&:to_hash)

  languages = headers.map do |header|
    language = {}

    language[header] = translations.reduce({}) do |memo, translation|
      key = translation[master]
      value = translation[header]

      key_path = key.split('.')

      hash = memo

      loop do

        if key_path.length == 1
          value.strip! rescue puts "Error in #{key_path}" # TODO: Handle errors
          value = YAML.load(value) if key_path.first.end_with? '_list'

          hash[key_path.first] = value
        else
          step_hash = hash[key_path.first] || {}
          hash[key_path.first] = step_hash
          hash = step_hash
        end

        key_path.slice!(0)

        break if key_path.empty?
      end

      memo
    end

    language
  end

  languages.each do |language|
    File.open("_locales/#{language.keys.first}.yml", 'w') do |f|
      f.write "# Do not edit this generated file\n"
      f.write language.to_yaml
    end
  end
end

