Gem::Specification.new do |spec|
  spec.name = 'snippet'
  spec.version = '0.0'
  spec.author = 'Tomasz Pewiński'
  spec.email = 'pewniak747@gmail.com'
  spec.platform = Gem::Platform::RUBY
  spec.summary = 'Simple gem used for quick jekyll-and-git-based posting'
  spec.files = ["lib/post.rb", "lib/snippet.rb", "test/test_post.rb", "bin/snippet"]
  spec.default_executable = "snippet"
  spec.executables = ["snippet"]
  spec.require_path = 'lib'
  spec.extra_rdoc_files = ["README"]
  spec.add_dependency('git')
  spec.description = 'Simple gem used for quick jekyll-and-git-based posting'
	spec.homepage = "http://github.com/pewniak747/snippet"
end
