// fails on a key of the dictionary `given` that `known` lacks,
// the message is prefixed w/ `scope` (e.g. "units")
#let assert-keys(given, known, scope) = for name in given.keys() {
  assert(
    name in known,
    message: scope + ": unknown `" + name + "`, expected " + known.keys().join(", "),
  )
}
