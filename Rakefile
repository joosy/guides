deploy_dir = "build"

task :prepare do
  puts "Build directory found, please remove it."; exit if File.exists? deploy_dir
  system "git clone https://github.com/joosy/guides #{deploy_dir}"
  cd(deploy_dir) { system "git checkout gh-pages" }
end

task :push do
  Dir["#{deploy_dir}/*"].each { |f| rm_rf(f) }
  system "bundle exec jekyll build"

  cd "#{deploy_dir}" do
    system "git add -A"
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m \"#{message}\""
    system "git push origin gh-pages"
  end
end