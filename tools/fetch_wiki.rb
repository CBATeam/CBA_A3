require 'rake'
require 'net/http'
require 'net/http'
require 'uri'
require 'set'
require 'fileutils'
include Net

HOST = 'dev-heaven.net'
ATTACHMENTS_DIR = 'attachments'
EXPORT_HTML = '?format=html'

USER_AGENT = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1'
GET_OPTIONS = { 'User-Agent' => USER_AGENT }

# Fetch the wiki page, all those pages it links to in its own wiki, and all
# attached images.
module Wiki
  def self.fetch(project, page, destination, exclude = Set.new(), getCSS = true)
    # Get the full version so we can find attachments.
    addr = "/projects/#{project}/wiki/#{page}"
    h = HTTP.new(HOST)
    h.use_ssl = true
    h.verify_mode = OpenSSL::SSL::VERIFY_NONE
    text = h.request_get(addr, GET_OPTIONS).body
    exclude.add page.downcase

    while text =~ %r["/(#{ATTACHMENTS_DIR}/\d+/([\w\-]+\.\w+))"]i
      image_name = $2

      h = HTTP.new(HOST)
      h.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  h.use_ssl = true
      image = h.request_get("/#{$1}", GET_OPTIONS).body

      File.open("#{destination}/#{image_name}", 'wb') do |file|
        file.write(image)
      end

      puts "Fetched #{image_name} (#{image.length} bytes)"

      text = $'
    end

    # Get the simple version for wiki links and actual download.
    path = "#{addr}#{EXPORT_HTML}"
    h = HTTP.new(HOST)
    h.verify_mode = OpenSSL::SSL::VERIFY_NONE
    h.use_ssl = true
    text = h.request_get(path, GET_OPTIONS).body
	text.gsub!(%r[href="/]) do |match|
		"href=\"http://#{HOST}/"
	end
	text.sub!('</style>', %[</style>\n<link href="application.css" media="all" rel="stylesheet" type="text/css" />])
	
    File.open("#{destination}/#{page}.html", 'w') do |file|
      file.puts text
    end
	
	if getCSS
		# baseCSS = HTTP.new(HOST).request_get('/stylesheets/application.css?1244929454', GET_OPTIONS).body
		# puts "Fetched (base) application.css (#{text.length} bytes)"
		# themeCSS = HTTP.new(HOST).request_get('/themes/dh_squish/stylesheets/application.css?1244929454', GET_OPTIONS).body
		# puts "Fetched (theme) application.css (#{themeCSS.length} bytes)"
		# css = themeCSS.sub!(/^@.*$/, baseCSS)
		css =<<END_CSS
a.wiki-anchor {
	color:white;
}
ul.toc {
	border:1px solid black;
	background:#DDDDDD;
	padding: 0.5em 1em 1em 1em;
}
pre {
	border:1px solid black;
	background:#C0C0C0;
	padding: 1em 1em 1em 1em;
	font-size:120%;
}
ul.right {
	float: right;
	margin: 0.5em 0 1em 2em;
}
body {
	margin: 3em 2em 4em 2em;
}
END_CSS
			
		File.open("#{destination}/application.css", 'w') do |file|
			file.puts css
		end
		puts "Generated application.css (#{css.length} bytes)"
		getCSS = false
	end

	puts "Fetched #{page}.html (#{text.length} bytes)"
		
    while text =~ /<a href\="(\w+)\.html"/
      name = $1

      fetch(project, name, destination, exclude, getCSS) unless exclude.include? name.downcase

      text = $'
    end
  end
end
  
if $0 == __FILE__
  unless ARGV.size == 3
    puts "Usage: ruby #{File.basename($0)} PROJECT START_PAGE OUT_DIR"
    exit
  end

  project, start_page, out_dir = ARGV

  FileUtils.mkdir_p out_dir

  Wiki.fetch(project, start_page, out_dir)
end
