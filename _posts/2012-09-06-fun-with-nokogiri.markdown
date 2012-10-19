---
title: Fun with Nokogiri and XKCD
---

I was bored and decided to play around with XPath and see what I could quickly
script up in a half hour or so. Below is the result.

    #!/usr/bin/env ruby
    require 'open-uri'
    require 'nokogiri'
    
    @uri = "http://www.xkcd.com/"
    @comics = Array.new
    
    doc = Nokogiri::HTML(open("#{@uri}/archive"))
    
    doc.xpath('//div[@id="middleContainer"]/a').each do |link|
      @comics << URI(link['href'])
    end
    
    @comics.each do |link|
      doc = Nokogiri::HTML(open("#{@uri}#{link}"))
      doc.xpath('//div[@id="comic"]').each do |image|
        image.children.each do |child|
          if child.node_name == 'img'
            uri = URI(child['src'])
            Net::HTTP.start(uri.host) do |http|
              resp = http.get(uri.path)
              open(File.basename(uri.path), "wb") do |file|
                file.write(resp.body)
              end
            end
            puts "Grabbing #{uri}"
          end
        end
      end
    end

The source code is also available on [github] [xkcd_scraper]. Be nice to
Randall's server though!

[xkcd_scraper]: http://www.github.com/sensae/xkcd_scraper
