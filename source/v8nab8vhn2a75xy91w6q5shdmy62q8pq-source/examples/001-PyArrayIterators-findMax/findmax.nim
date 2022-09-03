# Copyright (c) 2015 SnapDisco Pty Ltd, Australia.
# All rights reserved.
# 
# This source code is licensed under the terms of the MIT license
# found in the "LICENSE" file in the root directory of this source tree.

## Several short examples of how to read through the values in a PyArrayObject
## to find the maximum value in a Numpy array.  Each example uses a different
## PyArrayIter looping idiom.
##
## Compile this Nim module using the following command:
##   python ../../pmgen.py findmax.nim

import strutils  # `%`
import pymod
import pymodpkg/docstrings
import pymodpkg/pyarrayobject


proc findMax1*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `for`-loop idiom of read-only values.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for val in arr.values(int32):  # Yield each array value, one-by-one.
      if val > result:
        result = val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc findMax2*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `for`-loop idiom with a `PyArrayForwardIter[T]`.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for iter in arr.iterateFlat(int32).iitems:  # Forward-iterate through the array.
      if iter[] > result:
        result = iter[]
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc findMax3*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `for`-loop idiom with a `PyArrayForwardIter[T]`.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for val in arr.iterateFlat(int32):  # Yield read-only values.
      if val > result:
        result = val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc findMax4*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `for`-loop idiom with a `PyArrayForwardIter[T]`.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for mval in arr.iterateFlat(int32).mitems:  # Yield mutable values.
      if mval > result:
        result = mval
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc findMax5*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `while`-loop idiom with a `PyArrayForwardIter[T]`.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    let bounds = arr.getBounds(int32)  # Iterator bounds
    var iter = arr.iterateFlat(int32)  # Forward iterator
    while iter in bounds:
      if iter[] > result:
        result = iter[]
      inc(iter)  # Increment the iterator manually.
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc findMax6*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]`.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for iter in arr.accessFlat(int32).iitems:  # Flat-iterate through the array.
      if iter[0] > result:
        result = iter[0]
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc findMax7*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]`.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for val in arr.accessFlat(int32):  # Yield read-only values.
      if val > result:
        result = val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc findMax8*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]`.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for mval in arr.accessFlat(int32).mitems:  # Yield mutable values.
      if mval > result:
        result = mval
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc findMax9*(arr: ptr PyArrayObject): int32 {.exportpy} =
  docstring"""Find & return the maximum value in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  No values in the array will be changed.

  This example shows the `while`-loop idiom with a
  `PyArrayRandAccIter[T]`.
  """
  result = low(int32)
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    let bounds = arr.getBounds(int32)  # Iterator bounds
    var iter = arr.accessFlat(int32)  # Random access iterator
    while iter in bounds:
      if iter[] > result:
        result = iter[]
      inc(iter)  # Increment the iterator manually.
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


initPyModule("_findmax", findMax1, findMax2, findMax3, findMax4, findMax5,
    findMax6, findMax7, findMax8, findMax9)
