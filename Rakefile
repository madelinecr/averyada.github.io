require 'jekyll'
require 'jekyll-paginate'
require 'html-proofer'

task :default => :test

STAGECONF = "_config.yml,_config-staging.yml"
STAGETARGET = "local.ens.ae:~/public_html/blog-staging/"


desc "Tests the rendered HTML to make sure it's accurate"
task :test do
  system('jekyll build')
  HTML::Proofer.new('./_site', { :disable_external => true }).run
end

desc "Starts jekyll optimized for general site development"
task :dev do
  system('jekyll serve -w')
end

desc "Starts jekyll optimized for writing drafts"
task :write do
  system('jekyll serve -w -D')
end

desc "Pushes the site to the local staging server"
task :stage do
  system("jekyll build --config #{STAGECONF}; rsync -vaz _site/ #{STAGETARGET}")
  puts "Site has been staged to #{STAGETARGET}"
end

desc "Publishes the current working tree to Github Pages"
task :publish do
  Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "_site",
    "config"      => "_config.yml"
  })).process

  # The URL at which to publish the site.
  origin = `git config --get remote.origin.url`

  Dir.mktmpdir do |tmp|
    cp_r "_site/.", tmp
    Dir.chdir tmp

    system "git init"
    system "git remote add origin #{origin}"
    system "git add -A . && git commit -m 'Site updated at #{Time.now.utc}'"

    # Publish the site!
    system "git push origin master --force"
  end
end
