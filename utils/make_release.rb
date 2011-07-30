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
DOCS_DIR = File.join(RELEASE_FOLDER, '@CBA', 'store')
KEYS_DIR = File.join(RELEASE_FOLDER, '@CBA', 'store', 'keys')
SOURCE_DIR = File.join(RELEASE_FOLDER, '@CBA', 'store', 'source')
 
rmtree RELEASE_FOLDER
rm PACKAGE if File.exist? PACKAGE

mkdir_p ADDONS_DIR
mkdir_p DOCS_DIR
mkdir_p KEYS_DIR
mkdir_p SOURCE_DIR

cp 'CBA_README.txt', File.join(RELEASE_FOLDER, "CBA_#{versionSafe}_README.txt"), :preserve => true

cp "CBA_#{versionSafe}.bikey", KEYS_DIR, :preserve => true

Dir.new('../addons/').each do |file|
	file_path = "../addons/#{file}"
	if (not ['..', '.'].include? file) and File.directory? file_path
		cp_r(file_path, SOURCE_DIR, :preserve => true)
	elsif file =~ /\.(pbo|bisign)$/
		cp(file_path, ADDONS_DIR, :preserve => true)
	end
end

cp '../store/function_library.tar', DOCS_DIR, :preserve => true
cp '../store/wiki.tar', DOCS_DIR, :preserve => true

cd 'release'
%x[7z a #{FOLDER} #{FOLDER}/]
%x[7z a -tzip #{FOLDER} #{FOLDER}/]

