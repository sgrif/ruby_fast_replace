extern crate libc;

use std::ffi::CStr;
use std::{slice, str, mem};

#[repr(C)]
pub struct RubyStr {
    data: *const libc::c_char,
    len: libc::c_long,
}

impl RubyStr {
    fn as_str(&self) -> &str {
        unsafe {
            let bytes = slice::from_raw_parts(self.data as *const u8, self.len as usize);
            str::from_utf8_unchecked(bytes)
        }
    }

    fn from_str(string: &str) -> Self {
        RubyStr {
            data: string.as_ptr() as *const libc::c_char,
            len: string.len() as libc::c_long,
        }
    }
}

#[no_mangle]
pub extern "C" fn ruby_str_replace(
    haystack: RubyStr,
    needle: RubyStr,
    replacement: RubyStr,
) -> RubyStr {
    let mut replaced = haystack.as_str().replace(needle.as_str(), replacement.as_str());
    replaced.shrink_to_fit();
    let leaked_str = unsafe { mem::transmute(&*replaced) };
    mem::forget(replaced);
    RubyStr::from_str(leaked_str)
}

#[no_mangle]
pub extern "C" fn drop_ruby_str(ruby_str: RubyStr) {
    unsafe {
        mem::drop(String::from_raw_parts(
            ruby_str.data as *mut _,
            ruby_str.len as usize,
            ruby_str.len as usize,
        ))
    }
}
