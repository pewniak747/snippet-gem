#!/usr/bin/ruby

require 'date'
require 'rubygems'
require 'git'

class Post
	
	attributes = [:title, :description, :language, :date, :code, :errors, :working_dir, :posts_dir]
	attributes.each do |attr|
		attr_accessor attr
	end
		
		def initialize(options = {})
			@title = options[:title]
			@description = options[:description]
			@language = options[:language]
			@working_dir = options[:working_dir]
			@posts_dir = options[:posts_dir]
			@date = Date.today
			@code = options[:code]
			@errors = []
			return if !valid?
			if !@code
				puts 'Insert some code. Type END to continue.'
				@code = get_code
			end
		end
		
		def send
			if valid? == false 
				puts "Errors occured: #{@errors.join(', ')}"
				return false
			end
			
			file = File.new(generate_filename, 'w+')
			file.print write_content
			file.close
			
			repo = Git.open(@working_dir)
			repo.add(generate_filename)
			repo.commit("New snippet: #{@title}")
			repo.push
		
		end
		
private
		
		def write_content
			if valid? == false
				return nil
			end
			return %[
---
layout: post
title: #{@title}
---
#{@description}
{% highlight #{@language} %}
#{@code}
{% endhighlight %}
]
		end
	
		def valid?
			validate
			@errors.empty?
		end	
		
		def generate_filename
			if valid? == false 
				return nil
			end
			
			return "#{@working_dir}#{@posts_dir}#{@date.year}-#{date.month}-#{date.day}-#{@title.sub(' ', '-')}.textile"
		end

		def validate
			@errors.clear
			if !@title || @title.empty?
				@errors << 'Title cannot be empty'
			end
			#if !@code || @code.empty?
			#	@errors << 'Snippet must contain code'
			#end
			if !@working_dir || @working_dir.empty?
				@errors << 'You must specify working directory'
			end
			if !@posts_dir || @posts_dir.empty?
				@errors << 'You must specify posts directory'
			end
			if @working_dir 
				if !File.directory?(@working_dir)
					@errors << "Working directory not valid"
				end
			end
			if @posts_dir
				if !File.directory?(@working_dir+@posts_dir)
					@errors << 'Posts directory not valid'
				end
			end
		end
		
		def get_code
			$/ = "END"
			new_code = STDIN.gets.sub(/\nEND$/, '')
			#puts new_code
		end
		
end
