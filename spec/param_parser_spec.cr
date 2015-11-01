require "./spec_helper"

describe "ParamParser" do
  it "parses query params" do
    route = Route.new "POST", "/" do |env|
      hasan = env.params["hasan"]
      "Hello #{hasan}"
    end
    request = HTTP::Request.new("POST", "/?hasan=cemal")
    params = Kemal::ParamParser.new(route, request).parse
    params["hasan"].should eq "cemal"
  end

  it "parses request body" do
    route = Route.new "POST", "/" do |env|
      name = env.params["name"]
      age = env.params["age"]
      hasan = env.params["hasan"]
      "Hello #{name} #{hasan} #{age}"
    end
    request = HTTP::Request.new("POST", "/?hasan=cemal", body: "name=serdar&age=99")
    params = Kemal::ParamParser.new(route, request).parse
    params.should eq({"hasan" => "cemal", "name" => "serdar", "age" => "99"})
  end
end