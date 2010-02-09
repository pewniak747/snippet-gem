require '../lib/post'

describe "Post tests" do
	
	it "should initialize new Post" do
		post = Post.new
		post.kind_of?(Post).should == true
	end
	
end
