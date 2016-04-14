require "mkmf"

have_library("rust_example", "rust_example_init")
libdir = File.expand_path("../../lib", __FILE__)
$LOCAL_LIBS << "-L#{libdir} -lstuff "

create_makefile("rust_example/rust_example")
