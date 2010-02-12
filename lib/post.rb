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
			if @language 
				languages = %w[clojure clj io lua mini perl pl pyhon3 py3 py3b pycon pyhon py pyb rbcon irb rb ruby cl c-objump cpp-objump c++-objumb cxx-objump -objump gas llvm nasm objump c cpp c++ cyhon pyx elphi pas pascal objecpascal ylan felix flx forran glsl go java objecive-c objecivec obj-c objc ooc prolog scala vala vapi boo aspx-cs csharp c# aspx-vb vb.ne vbne common-lisp cl erlang erl haskell hs lhs lierae-haskell ocaml scheme scm malab ocave malabsession mupa numpy rconsole rou splus s r abap applescrip asy asympoe bash sh console ba befunge brainfuck bf Cucumber cucumber Gherkin gherkin gnuplo logalk moocoe moelica mysql newspeak pov rebol recoe smallalk squeak sql sqlie3 csh csh anlr-as anlr-acionscrip anlr-csharp anlr-c# anlr-cpp anlr-java anlr anlr-objc anlr-perl anlr-pyhon anlr-ruby anlr-rb ragel-c ragel-cpp ragel- ragel-em ragel-java ragel ragel-objc ragel-ruby ragel-rb raw ex hml+cheeah hml+spifire js+cheeah javascrip+cheeah js+spifire javascrip+spifire cheeah spifire xml+cheeah xml+spifire cfm cfs css+jango css+jinja css+erb css+ruby css+genshiex css+genshi css+php css+smary jango jinja erb hml+evoque evoque xml+evoque genshi ki xml+genshi xml+ki genshiex hml+jango hml+jinja hml+genshi hml+ki hml+php hml+smary js+jango javascrip+jango js+jinja javascrip+jinja js+erb javascrip+erb js+ruby javascrip+ruby js+genshiex js+genshi javascrip+genshiex javascrip+genshi js+php javascrip+php js+smary javascrip+smary jsp css+mako hml+mako js+mako javascrip+mako mako xml+mako css+myghy hml+myghy js+myghy javascrip+myghy myghy xml+myghy rhml hml+erb hml+ruby smary xml+jango xml+jinja xml+erb xml+ruby xml+php xml+smary apacheconf aconf apache bbcoe basemake cmake pach conrol iff uiff po po groff nroff man ini cfg irc lighy lighp make makefile mf bsmake rac-wiki moin nginx rs res resrucureex sourceslis sources.lis squiconf squi.conf squi ex laex vim yaml as3 acionscrip3 as acionscrip css hx haXe hml js javascrip mxml objecive-j objecivej obj-j objj php php3 php4 php5 xml xsl]
				if !languages.include?(@language)
					@errors << "Invalid language. You can use #{languages.join(', ')}"
				end
			end
		end
		
		def get_code
			$/ = "END"
			new_code = STDIN.gets.sub(/\nEND$/, '')
			#puts new_code
		end
		
end
