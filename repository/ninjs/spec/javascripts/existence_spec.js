describe("Existence:", function() {

  it("should test for existence with is_defined", function() {  
    var nonexistent;
  	var existent = 'I think';
  	expect(is_defined(existent)).toBeTruthy();
    expect(is_defined(nonexistent)).toBeFalsy();
  });

  it("should test for non-existence with is_undefined", function() {
    var existent = 'I think';
    var nonexistent;
    expect(is_undefined(nonexistent)).toBeTruthy();
    expect(is_undefined(existent)).toBeFalsy();
  });

  it("should check for type strictly with is_typeof", function() {
    var foo = function(){};
    var bar = {
      name: 'SomeObject',
      method: function() {}
    };
    var SomeClass = function(){};
    var some_instance = new SomeClass();

    expect(is_typeof(Number, 4)).toBeTruthy();
    expect(is_typeof(String, 'Hello World')).toBeTruthy();
    expect(is_typeof(Array, ['one', 'two', 'three'])).toBeTruthy();
    expect(is_typeof(Function, foo)).toBeTruthy();
    expect(is_typeof(Object, bar)).toBeTruthy();
    expect(is_typeof(RegExp, /pattern/)).toBeTruthy();
    expect(is_typeof(SomeClass, some_instance)).toBeTruthy();
    
    expect(is_typeof(Object, 4)).toBeFalsy();
    expect(is_typeof(Object, 'Hello World')).toBeFalsy();
    expect(is_typeof(Object, ['one', 'two', 'three'])).toBeFalsy();
    expect(is_typeof(Object, foo)).toBeFalsy();
    expect(is_typeof(Function, bar)).toBeFalsy();
    expect(is_typeof(Object, some_instance)).toBeFalsy();
    expect(is_typeof(Function, some_instance)).toBeFalsy();
  });

  it("should check for default types with convenience methods", function() {
    var today = new Date();
    var easy_as = [1,2,3];
    var pattern = new RegExp(/pattern/);

    expect(is_string('hello')).toBeTruthy();
    expect(is_number(42)).toBeTruthy();
    expect(is_array(easy_as)).toBeTruthy();
    expect(is_bool(false)).toBeTruthy();
    expect(is_date(today)).toBeTruthy();
    expect(is_regex(pattern)).toBeTruthy();

    expect(is_regex('hello')).toBeFalsy();
    expect(is_date(42)).toBeFalsy();
    expect(is_bool(easy_as)).toBeFalsy();
    expect(is_array(today)).toBeFalsy();
    expect(is_number(true)).toBeFalsy();
    expect(is_string(pattern)).toBeFalsy();
  });

  it("should determine if a given string is numerical", function() {
    expect(is_numeric(2)).toBeTruthy();
    expect(is_numeric(-2)).toBeTruthy();
    expect(is_numeric(45.6)).toBeTruthy();
    expect(is_numeric(-45.6)).toBeTruthy();
    expect(is_numeric('45.6')).toBeTruthy();
    expect(is_numeric('Hello')).toBeFalsy();
  });
});