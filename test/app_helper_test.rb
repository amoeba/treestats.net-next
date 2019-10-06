require "./test/test_helper"

class AppHelperTest < MiniTest::Test
  include Sinatra::AppHelper

  def test_get_page
    assert_equal(get_page(nil), 1)
    assert_equal(get_page("hi!"), 1)
    assert_equal(get_page({page: -1}), 1)
    assert_equal(get_page({page: "asdf"}), 1)
    assert_equal(get_page({page: 2}), 2)
  end

  def test_to_params
    assert_equal(to_params(nil), "")
    assert_equal(to_params([]), "")
    assert_equal(to_params({a: 1}), "a=1")
    assert_equal(to_params({a: 1, b: "foo"}), "a=1&b=foo")
    assert_equal(to_params({a: 1, b: "foo bar"}), "a=1&b=foo+bar")
  end
end
