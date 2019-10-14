require "./test/test_helper"

class AppTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def test_hello_world
    get "/"
    assert last_response.ok?
  end
end
