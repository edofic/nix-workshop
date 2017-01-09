Start reading here:
http://lethalman.blogspot.si/2014/07/nix-pill-1-why-you-should-give-it-try.html

# Intro

- entries in /nix/store are immutable
- /nix/store itself is mutable, but subject to liveness constraints
- nix-collect-garbage
- liveness?
  - entries in the store depend on other entries (there is a database)
  - entries don't depend on anything else
    - no global state
    - no /usr/lib, /usr/bin
    - no /usr/share/..
    - no $PATH!
  - this means we can take a closure and ship it
  - there are roots
    - profiles
    - generations

# nix-env

- nix-env -q
- nix-env -i nix-repl
- nix-env --help
- there are generations
- how does it work?
  - symlink farm

# nix-store

- low level queries and manipulation
- e.g. list closure for package x
- dump package into a file
- query dependencies
- collect garbage

# nix-channel

- where `<nixpkgs>` comes from
- nix-channel --help
- zengrc is not using this mechanism in order to avoid "it work on my machine"


# Nix - the language

- lazy, purely functional, dynamically typed
  - kind of like an ML
  - yes pure, building stuff is done outside the language, fetching dependencies
    is protected by a hash
- space for application: `f x`
- string interpolation `"${foo}bar"`
- `''multiline strings''`
- `[ funky "list" "syntax ] # no commas`
- `{ foo: "bar"; "baz" = quux; nested.thingy = 1 }`
  - called sets, actually more like python dicts
  - yes, semicolons
  - lazy again
  - `rec { foo = 1; bar = foo; }`
- `if a then b else c` is an expression
- `let a = b; c = d; in a + c`
- `let longNameHere = { a = 1; b = 2; }; in with longNameHere; a + b`
- `addOne = x: x + 1`
- curried: `add = a: b: a+b`
- "destructuring" or "arguments set": `add = {a, b ? 1, ... }: a + b`
- import is an expression `x = import ./x`

# Derivations

- there is a built-in function `derivation` but we are not going to go this low
  level read the nix pill 6 and on to understand how it works. We are going to
  use the stdlib helper `nixpkgs.stdenv.mkDerivation`
- example1.nix:
  - simplest way is the build command
  - nix-build example1.nix
  - bind the .drv: low level build recipe (nix-store realise)
  - `ls -lah`
  - `file result`
  - `cat result`
- example2:
  - `src`
  - default.nix
- example3
  - default is C-style makefile
  - there is unpacking
  - patching
  - configuring
  - building
  - installing
  - and more. read [the source](https://github.com/NixOS/nixpkgs/blob/ff35c4a5e2df6c3b2c3a6ddcbb756112cb024e62/pkgs/stdenv/generic/setup.sh)
  - there are build inputs
    - build time
    - run time: `nix-store -qR result`
    - nix figures this out by looks at the build output and scanning for build
      time dependencies

