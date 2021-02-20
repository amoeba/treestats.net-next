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

  def test_upload
    post "/"
    assert !last_response.ok?

    post("/", JSON.generate(:server => "Foo", :name => "Bar"))
    assert !last_response.ok?

    post("/", JSON.generate(
      :server => "Foo",
      :name => "Bar",
      :rank => 1,
      :gender_id => 0,
      :heritage_id => 0
    ))

    assert last_response.ok?
  end
end
