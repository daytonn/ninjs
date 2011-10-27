describe("String utility tests", function() {

  it("should test for emptiness with is_empty and not_empty", function() {
    expect(''.is_empty()).toBeTruthy();
    expect('hey there'.is_empty()).toBeFalsy();
    expect('hey there'.not_empty()).toBeTruthy();
    expect(''.not_empty()).toBeFalsy();
  });

  it("should test for a numeric value", function() {
    expect('34'.is_numeric()).toBeTruthy();
    expect('0.5'.is_numeric()).toBeTruthy();
    expect('-34'.is_numeric()).toBeTruthy();
    expect('-0.5'.is_numeric()).toBeTruthy();
    expect('hello'.is_numeric()).toBeFalsy();
  });

  it("should trim a string with trim, ltrim, and rtrim", function() {
    expect(' hello '.trim()).toEqual('hello');
    expect(' hello '.ltrim()).toEqual('hello ');
    expect(' hello '.rtrim()).toEqual(' hello');
  });

  it("should iterate over each character with each", function() {
    var iteration_count = 0,
        test_chars = [],
        test_indices = [];

    '123'.each(function(character, index) {
      test_chars.push(character);
      test_indices.push(index);
      iteration_count++;
    });

    expect(test_chars[0]).toEqual('1');
    expect(test_chars[1]).toEqual('2');
    expect(test_chars[2]).toEqual('3');

    expect(test_indices[0]).toEqual(0);
    expect(test_indices[1]).toEqual(1);
    expect(test_indices[2]).toEqual(2);

    expect(iteration_count).toEqual(3);
  });

  it("should capitalize a String with capitalize", function() {
    expect('hello world'.capitalize()).toEqual('Hello world');
  });

  it("should reverse a string with reverse", function() {
    expect('hello world'.reverse()).toEqual('dlrow olleh');
    expect('satan oscillate my metallic sonatas'.reverse()).toEqual('satanos cillatem ym etallicso natas');
  });

  it("should convert to a number", function() {
    var whole_number = '32',
        decimal = '0.08',
        negative_number = '-32',
        negative_float = '-0.08';

    expect(whole_number.to_n()).toBe(32);
    expect(decimal.to_n()).toBe(0.08);
    expect(negative_number.to_n()).toBe(-32);
    expect(negative_float.to_n()).toBe(-0.08);
  });

  it("should pluck all instances of a sup-string within a string", function() {
    expect('one, two, three'.pluck(',')).toEqual('one two three');
  });

  it("should compress a string to single spaces", function() {
    var hard_space = 'one&nbsp;two&nbsp;&nbsp;three&nbsp;&nbsp;&nbsp;four&nbsp;&nbsp;&nbsp;&nbsp;five&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;six',
        soft_space = 'one two  three   four    five     six',
        mixed_space = 'one two &nbsp; three &nbsp;&nbsp;four &nbsp;&nbsp;&nbsp;five &nbsp;&nbsp;&nbsp;&nbsp;six';

    expect(hard_space.single_space()).toBe('one two three four five six');
    expect(soft_space.single_space()).toBe('one two three four five six');
    expect(mixed_space.single_space()).toBe('one two three four five six');
  });

  it("should compress a string, removing all whitespace", function() {
    var string = "satan\n\t oscillate\n\t my\n\t metallic\n sonatas";
    expect(string.compress()).toBe('satanoscillatemymetallicsonatas');
  });
});