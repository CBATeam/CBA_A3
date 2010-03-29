# encoding: utf-8

# Skeleton Addon - By Sickboy <sb_at_dev-heaven.net>
#
# requires: 
# mod\addons\main\script_mod.hpp
# mod\utils\skel.rb
# mod\utils\skel\*

require 'fileutils'
BASE_DIR = Dir.pwd
BASE_DIR[/(.*)\/(.*)/]
ROOT_DIR = $1

def abort
	STDIN.gets 
	Process.exit
end

component = gets.strip
if component.empty?
	puts "Component name is empty, aborting!"
end

m = File.open(File.join(ROOT_DIR, "addons/main/script_mod.hpp")) {|f| f.read}
m[/#define PREFIX (\w*)/]
prefix = $1

path = File.join(ROOT_DIR, "addons", component)

puts "#{prefix}_#{component}, #{path}"

if File.exist?(path)
	puts "Already exists, aborting!"
	STDIN.gets 
	Process.exit
end

FileUtils.mkdir_p path

Dir["skel/**/*"].each do |e|
	if !File.directory? e
		str = File.open(e) {|f| f.read }
		str.gsub!("__COMPONENT__", component)
		str.gsub!("__COMPONENTU__", component.upcase)
		str.gsub!("__PREFIX__", prefix)
		
		ne = e.sub!("skel/", "")
		ne.gsub!(".cpp.hpp", ".cpp")
		File.open(File.join(path, ne), "w") {|f| f.puts str}
	end
end

puts "Done!"
STDIN.gets
