describe("NinjsApplication", function() {
  var app;
  
  beforeEach(function() {
    app = new NinjsApplication('myapp');
  });
  
  afterEach(function() {
    app = undefined;
  });

  it("should create a ninjs application object", function() {
    expect(is_defined(app)).toBeTruthy();
    expect(is_typeof(NinjsApplication, app)).toBeTruthy();
  });

  it("should create a NinjsModule", function() {
  	app.add_module('mymod');
    expect(is_typeof(NinjsModule, app.mymod)).toBeTruthy();
  });
});