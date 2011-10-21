describe("NinjsModule", function() {

  var app;

  beforeEach(function() {
    app = new NinjsApplication('myapp');
  });

  it("should return the module when added", function() {
    var module = app.add_module('mymod');
    expect(module).toEqual(app.mymod);
  });

  it("should have the correct default values", function() {
    app.add_module('testmodule');
    // properties    
    expect(is_defined(app.testmodule.data)).toBeTruthy();
    expect(is_defined(app.testmodule.name)).toBeTruthy();
    expect(app.testmodule.name).toEqual('testmodule');

    // methods
    expect(is_defined(app.testmodule.actions)).toBeTruthy();
    expect(is_typeof(Function, app.testmodule.actions)).toBeTruthy();
    expect(is_defined(app.testmodule.run)).toBeTruthy();
    expect(is_typeof(Function, app.testmodule.run)).toBeTruthy();
    expect(is_defined(app.testmodule.execute)).toBeTruthy();
    expect(is_defined(app.testmodule.elements)).toBeTruthy();
    expect(is_defined(app.testmodule.set_data)).toBeTruthy();
  });
});