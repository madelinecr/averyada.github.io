require 'html/proofer'

task :default => :dev

STAGECONF = "_config.yml,_config-staging.yml"
STAGETARGET = "local.ens.ae:~/public_html/blog-staging/"


desc "Tests the rendered HTML to make sure it's accurate"
task :test do
  system('jekyll build')
  HTML::Proofer.new('./_site', { :disable_external => true }).run
end

desc "Starts jekyll optimized for general site development"
task :dev do system('jekyll serve -w') end

desc "Starts jekyll optimized for writing drafts"
task :write do
  system('jekyll serve -w -D')
end

desc "Pushes the site to the local staging server"
task :stage do
  system("jekyll build --config #{STAGECONF}; rsync -vaz _site/ #{STAGETARGET}")
  puts "Site has been staged to #{STAGETARGET}"
end
