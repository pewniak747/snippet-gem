require 'post'
require 'optparse'

class Snippet
	attr_accessor :defaults
	

	def self.parse(args)
		options = {}

		opts = OptionParser.new do |opts|
		
			opts.on("-t", "--title [TITLE]", "Provide title for snippet") do |title|
				options[:title] = title
			end
			
			opts.on("-l", "--lang [LANGUAGE]", "Provide programming language for snippet") do |lang|
				options[:language] = lang
			end
			
			opts.on("-c", "--code [code]", "Provide code for snippet") do |code|
				options[:code] = code
			end
		
			opts.on_tail("-h", "--help", "Show this message") do
				puts opts
				exit
			end
			
			opts.on_tail("-v", "--version", "Show script version") do
				puts "0.0"
				exit
			end
    
		end
		opts.parse!(args)
		return options
	end

end

options = Snippet.parse(ARGV)
if !options[:working_dir]
		options[:working_dir] = '/home/pewniak747/Projekty/pewniak747.github.com/'
end
if !options[:posts_dir]
		options[:posts_dir] = 'snippets/_posts/'
end
if !options[:language]
	options[:language] = 'shell'
end

p options

post = Post.new(options)
puts post.working_dir
post.send
