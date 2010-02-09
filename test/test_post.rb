require 'test/unit'
require 'post'

class PostsTest < Test::Unit::TestCase

	def setup
		@attrs = {
			:title => 'lol',
			:code => 'code',
			:working_dir => '/home/pewniak747/Projekty/pewniak747.github.com/',
			:posts_dir => 'snippets/_posts/',
			:language => 'shell'
		}
	end
	
	def test_kindof
		post = Post.new(@attrs)
		assert_kind_of(Post, post)
	end
	
	def test_blanktitle
		post = Post.new(@attrs.merge(:title => nil))
		assert_equal post.valid?, false
		post.title = ""
		assert_equal post.valid?, false
		post.title = "Proper title"
		assert_equal post.valid?, true
	end
	
	def test_blankcode
		post = Post.new(@attrs.merge(:code => nil))
		assert_equal post.valid?, false 
		post.code = ""
		assert_equal post.valid?, false 
		post.code = "Proper code"
		assert_equal post.valid?, true
	end
	
	def test_bad_workingdir
		post = Post.new(@attrs.merge(:working_dir => '/lol/'))
		assert_equal post.valid?, false
	end
	
	def test_bad_postdir
		post = Post.new(@attrs.merge(:posts_dir => '/lol/'))
		assert_equal post.valid?, false
	end
	
end
