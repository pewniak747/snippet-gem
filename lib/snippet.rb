#!/usr/bin/ruby

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
			
			opts.on("-c", "--code [CODE]", "Provide code for snippet") do |code|
				options[:code] = code
			end
			
			opts.on("-w", "--working-directory [DIR]", "Provide blog's directory") do |dir|
				options[:working_directory] = dir
			end
		
			opts.on("-p", "--posts-directory [DIR]", "Provide post's subdirectory") do |dir|
				options[:posts_dir] = dir
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
