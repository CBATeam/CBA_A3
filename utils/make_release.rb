require 'fileutils'
include FileUtils

unless ARGV.size == 1
	puts "Usage: #{$0} VERSION"
	exit
end

version = ARGV[0]
versionSafe = version.gsub('.', '-')

FOLDER = "CBA_#{versionSafe}"
RELEASE_FOLDER = File.join('release', FOLDER)
PACKAGE = "#{RELEASE_FOLDER}.7z"
ADDONS_DIR = File.join(RELEASE_FOLDER, '@CBA', 'addons')
DOCS_DIR = File.join(RELEASE_FOLDER, 'docs')
KEYS_DIR = File.join(RELEASE_FOLDER, 'keys')
SOURCE_DIR = File.join(RELEASE_FOLDER, 'source')
 
rmtree RELEASE_FOLDER
rm PACKAGE if File.exist? PACKAGE

mkdir_p ADDONS_DIR
mkdir_p DOCS_DIR
mkdir_p KEYS_DIR
mkdir_p SOURCE_DIR

cp 'CBA_README.txt', File.join(RELEASE_FOLDER, "CBA_#{versionSafe}_README.txt")

cp "CBA_#{versionSafe}.bikey", KEYS_DIR

Dir.new('../addons/').each do |file|
	file_path = "../addons/#{file}"
	if (not ['..', '.'].include? file) and File.directory? file_path
		cp_r(file_path, SOURCE_DIR)
	elsif file =~ /\.(pbo|bisign)$/
		cp(file_path, ADDONS_DIR)
	end
end

cp_r '../docs/cba_function_library', DOCS_DIR
cp_r '../docs/cba_wiki', DOCS_DIR

cd 'release'
%x[7z a #{FOLDER} #{FOLDER}/]