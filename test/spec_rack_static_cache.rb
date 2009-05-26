require 'test/spec'

require 'rack'
require 'rack/contrib/static_cache'
require 'rack/mock'

class DummyApp
  def call(env)
    [200, {}, ["Hello World"]]
  end
end

describe "Rack::StaticCache" do
  root = ::File.expand_path(::File.dirname(__FILE__))
  OPTIONS = {:urls => ["/statics"], :root => root}

  setup do
    @request = Rack::MockRequest.new(Rack::StaticCache.new(DummyApp.new, OPTIONS))
  end

  it "should serve files with required headers" do
    res = @request.get("/statics/test")
    res.should.be.ok
    res.body.should =~ /ruby/
  end

  xit "should return 404s if url root is known but it can't find the file" do
    res = @request.get("/cgi/foo")
    res.should.be.not_found
  end

  xit "should call down the chain if url root is not known" do
    res = @request.get("/something/else")
    res.should.be.ok
    res.body.should == "Hello World"
  end

  xit "should serve files if requested with version number and versioning is enabled" do
  end

  xit "should return 404s if requested with version number but versioning is disabled" do
  end

  xit "should serve files with plain headers when * is added to the directory name" do
  end

  xit "should cache duration" do
    
  end

end