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
		
private

		def validate
			@errors.clear
			if !@title
				@errors << 'Title cannot be empty'
			end
			if !@code 
				@errors << 'Snippet must contain code'
			end
			if !@working_dir
				@errors << 'You must specify working directory'
			end
			if !@posts_dir
				@errors << 'You must specify posts directory'
			end
		end
		
end
