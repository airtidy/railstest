require 'test_helper'

class RankingControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get ranking_edit_url
    assert_response :success
  end

  test "should get view" do
    get ranking_view_url
    assert_response :success
  end

end
