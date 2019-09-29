require "./test/test_helper"

class AppHelperTest < MiniTest::Test
  include Sinatra::AppHelper

  def test_get_page
    assert get_page(nil) == 1
    assert get_page("hi!") == 1
    assert get_page({page: -1}) == 1
    assert get_page({page: "asdf"}) == 1
    assert get_page({page: 2}) == 2
  end

  def test_to_params
    assert to_params(nil) == ""
    assert to_params([]) == ""
    assert to_params({a: 1}) == "?a=1"
    assert to_params({a: 1, b: "foo"}) == "?a=1&b=foo"
    assert to_params({a: 1, b: "foo bar"}) == "?a=1&b=foo%20bar"
  end
end
