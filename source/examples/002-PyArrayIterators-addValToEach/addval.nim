# Copyright (c) 2015 SnapDisco Pty Ltd, Australia.
# All rights reserved.
# 
# This source code is licensed under the terms of the MIT license
# found in the "LICENSE" file in the root directory of this source tree.

## Several short examples of how to iterate through a PyArrayObject and
## add a user-specified `int32` value to each element in the Numpy array.
## Each example uses a different PyArrayIter looping idiom.
##
## Compile this Nim module using the following command:
##   python ../../pmgen.py addval.nim

import strutils  # `%`
import pymod
import pymodpkg/docstrings
import pymodpkg/pyarrayobject


proc addVal1*(arr: ptr PyArrayObject, val: int32) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a `PyArrayForwardIter[T]`.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for iter in arr.iterateFlat(int32).iitems:  # Forward-iterate through the array.
      iter[] += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addVal2*(arr: ptr PyArrayObject, val: int32) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a `PyArrayForwardIter[T]`.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for mval in arr.iterateFlat(int32).mitems:  # Yield mutable values.
      mval += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addVal3*(arr: ptr PyArrayObject, val: int32) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `while`-loop idiom with a `PyArrayForwardIter[T]`.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    let bounds = arr.getBounds(int32)  # Iterator bounds
    var iter = arr.iterateFlat(int32)  # Forward iterator
    while iter in bounds:
      iter[] += val
      inc(iter)  # Increment the iterator manually.
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addVal4*(arr: ptr PyArrayObject, val: int32) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]`.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for iter in arr.accessFlat(int32).iitems:  # Flat-iterate through the array.
      iter[] += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addVal5*(arr: ptr PyArrayObject, val: int32) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]`.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for iter in arr.accessFlat(int32).iitems:  # Flat-iterate through the array.
      iter[0] += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addVal6*(arr: ptr PyArrayObject, val: int32) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]`.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for mval in arr.accessFlat(int32).mitems:  # Yield mutable values.
      mval += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addValEachDelta1*(arr: ptr PyArrayObject, val: int32, incDelta: int) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array
  that is reached by incrementing the iterator by `incDelta`.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `while`-loop idiom with a
  `PyArrayRandAccIter[T]` and an increment delta.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    let bounds = arr.getBounds(int32)  # Iterator bounds
    var iter = arr.accessFlat(int32)  # Random access iterator
    while iter in bounds:
      iter[] += val
      inc(iter, incDelta)  # Increment the iterator manually.
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addValEachDelta2*(arr: ptr PyArrayObject, val: int32, incDelta: int) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array
  that is reached by incrementing the iterator by `incDelta`.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `while`-loop idiom with a
  `PyArrayRandAccIter[T]` and an increment delta.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    let bounds = arr.getBounds(int32)  # Iterator bounds
    var iter = arr.accessFlat(int32)  # Random access iterator
    while iter in bounds:
      iter[0] += val
      inc(iter, incDelta)  # Increment the iterator manually.
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addValEachDelta3*(arr: ptr PyArrayObject, val: int32, incDelta: int) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array
  that is reached by incrementing the iterator by `incDelta`.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]` and an increment delta.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for iter in arr.accessFlat(int32, incDelta).iitems:  # Flat-iterate through the array.
      iter[] += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addValEachDelta4*(arr: ptr PyArrayObject, val: int32, incDelta: int) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array
  that is reached by incrementing the iterator by `incDelta`.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]` and an increment delta.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for mval in arr.accessFlat(int32, incDelta).mitems:  # Yield mutable values.
      mval += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addValEachDeltaInitOffset1*(arr: ptr PyArrayObject; val: int32; initOffset, incDelta: int) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array that is reached by
  incrementing the iterator by `incDelta` after an initial offset of `initOffset`.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]` and an increment delta.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for iter in arr.accessFlat(int32, initOffset, incDelta).iitems:  # Flat-iterate through the array.
      iter[] += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


proc addValEachDeltaInitOffset2*(arr: ptr PyArrayObject; val: int32; initOffset, incDelta: int) {.exportpy} =
  docstring"""Add `val` to each element in the supplied Numpy array that is reached by
  incrementing the iterator by `incDelta` after an initial offset of `initOffset`.

  The array is assumed to have dtype `int32`; otherwise, a ValueError will be
  raised.  The elements in the array will be modified in-place.

  This example shows the `for`-loop idiom with a
  `PyArrayRandAccIter[T]` and an increment delta.
  """
  let dt = arr.dtype
  echo "PyArrayObject has shape $1 and dtype $2" % [$arr.shape, $dt]
  if dt == np_int32:
    for mval in arr.accessFlat(int32, initOffset, incDelta).mitems:
      mval += val
  else:
    let msg = "expected input array of dtype $1, received dtype $2" % [$np_int32, $dt]
    raise newException(ValueError, msg)


initPyModule("_addval", addVal1, addVal2, addVal3, addVal4, addVal5, addVal6,
    addValEachDelta1, addValEachDelta2, addValEachDelta3, addValEachDelta4,
    addValEachDeltaInitOffset1, addValEachDeltaInitOffset2)
