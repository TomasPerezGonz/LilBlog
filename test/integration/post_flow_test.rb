require 'test_helper'

class PostFlowTest < ActionDispatch::IntegrationTest
    def setup
        @one = posts(:first_post)
        @two = posts(:second_post)
        @three = posts(:third_post)
    end

    test "post index" do
        visit posts_path
        assert_content page, "Posts"
        assert_content page, @one.title
        assert_content page, @two.title
        assert_content page, @three.title
    end   

    test "post show" do
        visit posts_path
        click_link "Show #{@one.title}"
        assert_content page, @one.title
        assert_content page, @one.description
    end

    test "custom user flow" do
        # get to root
        visit posts_path
        #enter to three
        click_link "Show #{@three.title}"
        assert_content page, @three.title
        assert_content page, @three.description
        assert_content page, "Destroy this post"
        assert_content page, "Edit this post"
        assert_content page, "Back to posts"
        #delete Three
        click_button "Destroy this post"
        #return to root
        assert_content page, "Posts"
        assert_content page, @one.title
        assert_content page, @two.title
        #enter to two
        click_link "Show #{@two.title}"
        assert_content page, @two.title
        assert_content page, @two.description
        assert_content page, "Destroy this post"
        assert_content page, "Edit this post"
        assert_content page, "Back to posts"
        #return to root
        click_link "Back to posts"
        #enter to one
        click_link  "Show #{@one.title}"
    end
end
