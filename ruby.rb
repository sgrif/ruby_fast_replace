require "fiddle"

example = Fiddle.dlopen("target/debug/libstuff.dylib")

print_from_rust = Fiddle::Function.new(
  example["print_from_rust"],
  [Fiddle::TYPE_VOIDP],
  Fiddle::TYPE_VOID,
)

print_from_rust.call("Hello")
print_from_rust.call(" world")
