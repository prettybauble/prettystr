import
  prettystr,
  unittest


suite "Prettystring":

  test "add the numbers":
    var source: string

    source.add(9u8)  # Add uint8
    assert source[0] == '\x09'

    source.add(0u32)  # add 4 zero-bytes.
    assert source[1..4] == "\x00\x00\x00\x00"

    source.add(1i64)
    assert source[5..^1] == "\x01\x00\x00\x00\x00\x00\x00\x00"


  test "write the number":
    var source = "\x00\x00\x00\x00"

    source.write(0, 1024u32)  # write uint32 at 0 position.
    assert source == "\x00\x04\x00\x00"

    source.write(0, 125i8)  # write uint32 at 0 position.
    assert source == "\x7d\x04\x00\x00"


  test "insert the number":
    var source: string

    source.insert(0, 0u16)
    assert source == "\x00\x00"

    source.insert(1, 1u8)
    assert source == "\x00\x01\x00"

    source.insert(1, 1024u32)
    assert source == "\x00\x00\x04\x00\x00\x01\x00"

  test "read the number":
    var source = "\x00\x04\x00\x00"

    assert read[uint32](source, 0) == 1024
    assert read[uint16](source, 0) == 1024
    assert read[uint8](source, 1) == 4
    assert read[uint8](source, 0) == 0

  test "pop":
    var source = "\x01\x02\x03\x04"

    source.pop(1)
    assert source == "\x01\x03\x04"

    assert source.pop() == '\x04'
    assert source == "\x01\x03"
