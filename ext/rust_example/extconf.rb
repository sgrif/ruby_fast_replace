require "mkmf"

have_library("rust_example", "rust_example_init")
$LOCAL_LIBS << "-lstuff"

create_makefile("rust_example/rust_example")
