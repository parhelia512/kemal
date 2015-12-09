require "./spec_helper"

describe "Views" do
  it "renders file" do
    kemal = Kemal::Handler.new
    kemal.add_route "GET", "/view/:name" do |env|
      render "spec/asset/hello.ecr"
    end
    request = HTTP::Request.new("GET", "/view/world")
    response = kemal.call(request)
    response.body.should contain("Hello world")
  end

  it "renders layout" do
    kemal = Kemal::Handler.new
    kemal.add_route "GET", "/view/:name" do |env|
      render "spec/asset/hello.ecr", "spec/asset/layout.ecr"
    end
    request = HTTP::Request.new("GET", "/view/world")
    response = kemal.call(request)
    response.body.should contain("<html>Hello world")
  end
end
