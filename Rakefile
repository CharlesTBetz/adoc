# adapted from Pro Git rakefile

namespace :book do
  desc 'prepare build'
  task :prebuild do
    Dir.mkdir 'images' unless Dir.exists? 'images'
    Dir.glob("book/*/images/*").each do |image|
      FileUtils.copy(image, "images/" + File.basename(image))
    end
  end

  desc 'build basic book formats'
  task :build => :prebuild do
    puts "Converting to HTML..."
    `bundle exec asciidoctor adoc.asc`
    puts " -- HTML output at adoc.html"

    #puts "Converting to EPub..."
    #`bundle exec asciidoctor-epub3 adoc.asc`
    #puts " -- Epub output at adoc.epub"
    #
    #puts "Converting to Mobi (kf8)..."
    #`bundle exec asciidoctor-epub3 -a ebook-format=kf8 adoc.asc`
    #puts " -- Mobi output at adoc.mobi"
    # prefer a2x conversion
    puts "Converting to PDF... (this one takes a while)"
    `bundle exec asciidoctor-pdf adoc.asc 2>/dev/null`
    #`bundle exec asciidoctor-pdf adoc.asc`  # verbose

    puts " -- PDF  output at adoc.pdf"
  end
end

task :default => "book:build"
