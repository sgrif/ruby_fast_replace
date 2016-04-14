#include <ruby.h>

typedef struct {
  char* data;
  long len;
} ruby_str_t;

static inline ruby_str_t
STR2PARTS(VALUE str) {
  return (ruby_str_t) {
    .data = RSTRING_PTR(str),
    .len = RSTRING_LEN(str),
  };
}

ruby_str_t ruby_str_replace(ruby_str_t, ruby_str_t, ruby_str_t);
void drop_ruby_str(ruby_str_t);

static VALUE
rb_string_fast_replace(VALUE self, VALUE needle, VALUE replacement) {
  ruby_str_t new_value = ruby_str_replace(
      STR2PARTS(self),
      STR2PARTS(needle),
      STR2PARTS(replacement)
  );
  VALUE result = rb_utf8_str_new(new_value.data, new_value.len);
  drop_ruby_str(new_value);
  return result;
}

void Init_rust_example(void) {
  rb_define_method(rb_cString, "fast_replace", rb_string_fast_replace, 2);
}
