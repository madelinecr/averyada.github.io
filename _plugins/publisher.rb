#!/usr/bin/env ruby

require 'psych'

module Jekyll
  class PostPublisher < Generator
    safe true

    def replace(filepath, regex, *args, &block)
      content = File.read(filepath).gsub(regex, *args, &block)
      File.open(filepath, 'wb') { |file| file.write(content) }
    end

    def generate(site)
      @files = Dir["_publish/*"]
      @files.each do |f|
        now = DateTime.now
        replace(f, /---(.|\n)*---/) do |match|
          header = Psych.load(match)
          header["date"] = now.strftime("%Y-%m-%d %H:%M:%S")
          "#{header.to_yaml}---"
        end
        today = now.strftime("%Y-%m-%d")
        File.rename(f, "_posts/#{today}-#{File.basename(f)}")
      end
    end
  end
end
