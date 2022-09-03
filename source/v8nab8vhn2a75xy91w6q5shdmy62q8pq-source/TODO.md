* Since we now use unsigned arithmetic `+%` in `ptrutils`, remove `cast[int]` from PyArrayIter ptr pos comparisons.
* Change the default deref operator of PyArrayForwardIterator to check below the bounds, in addition to above the bounds, in case the memory address wraps around because the array is right at the top of the memory.
  * Provide an optimised iterator, that checks just once up front that the memory address won't wrap round within 1 increment after the end of the PyArray, and then doesn't need to check again.
* Allow exporting of the Nim types `npy_intp`, `Py_ssize_t`, `csize`.
* Add a command-line option to `pmgen.py` to enable Nim release mode.
* Add a function to the compiled Python module that returns bool of whether the module was compiled in release mode.
* Allow the user to specify their own choice of build directory name rather than `pmgen`.
  * Ultimately, this should be something that can be specified in "pymod-extensions.cfg".
  * For now, start with a command-line option `--pmgen_dir=DIRPATH`.
  * Note: After the Python module `.so` file is built, the Makefile moves it to `..`.
  * So `pmgen.py` needs to write the current absolute path, rather than `..`, into the Makefile.
* Add a command-line option `--pymod_name=MODNAME` to override the modname that is specified in `initPyModule`.
* Enable `void` as a Nim type that is supported for params & return values.
* If the user returns a `nil` string, ensure it is converted to an empty string.
* If the user returns a `nil` ptr PyObject or ptr PyArrayObject, ensure it becomes PyNone.
* Enable `bool` as a Nim type that is supported for params & return values.
  * Note that the Python C-API doesn't actually offer `bool` as a conversion type.
  * https://docs.python.org/2/c-api/arg.html
  * https://docs.python.org/2/c-api/bool.html
  * http://stackoverflow.com/questions/9316179/what-is-the-correct-way-to-pass-a-boolean-to-a-python-c-extension
* After that, enable `bool` parameter to be a default parameter.
  * Start at proc `getDefaultValue` in "pymodpkg/private/impls.nim".
* When a `ptr PyArrayObject` is being returned from an `exportpy`-ed Nim proc, annotate it `not nil`.
  * http://nim-lang.org/docs/manual.html#types-not-nil-annotation
  * This will enable compile-time checking to ensure you haven't forgotten to assign a result.
  * Otherwise, the C-API conversion-back-to-Python code receives a NULL pointer, and fails.
* Implement the procs planned for implementation in "pymodpkg/pyarrayobject.nim".
* Enable Python types to be passed from Python into Nim, so we can pass `numpy.int32` as an argument for example.
* Implement reading of double-hash comments into docstrings using `nim jsondoc myfile.nim`?
  * http://nim-lang.org/docs/docgen.html#document-types-json
* Read & use `pymod-extensions.cfg`!
* Fix all the millions of `FIXME` notes scattered through the code...
  * In general, a `FIXME` is there because I did something in a hacky way, that I think I should re-do properly.
