// fails on a key of the dictionary `given` that `known` lacks,
// the message is prefixed w/ `scope` (e.g. "units")
#let assert-keys(given, known, scope) = for name in given.keys() {
  assert(
    name in known,
    message: scope + ": unknown `" + name + "`, expected " + known.keys().join(", "),
  )
}

// fails if the arguments `args` hold positional ones, `scope` names the caller
// and `hint` how to pass them instead
#let assert-named(args, scope, hint) = assert(
  args.pos() == (),
  message: scope + ": got " + str(args.pos().len()) + " positional argument(s), " + hint,
)
