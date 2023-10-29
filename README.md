# Usage

Read and write spell data from a [Hex Casting](https://modrinth.com/mod/hex-casting) focus, via a [Ducky Peripherals](https://modrinth.com/mod/ducky-periphs) Focal Port.

`focus [command] (...)`
- `print` - Print focus contents out
- `read [filename]` - Save focus info into a file
- `write [filename]` - Read a spell into a focus

Files are in format of `DIRECTION aqwed` per line. Comments use `//`.

No install script for now. Use `wget` for the raw files for now. Can put them anywhere.

No guarantee that it will work with more than one [Focal Port](https://github.com/SamsTheNerd/ducky-periphs/wiki/Focal-Port)

# Todo

- Make it print more than just the patterns
- The above but for reading/writing the data
- Unify read and print implementation. Because what the heck is this right now?
- Make it actually work with `.hexpattern` stuff from [Hex Studio](https://github.com/Master-Bw3/Hex-Studio)
- HTTP(S) link support for write command?
- Figure out okay names for `read` and `write` commands. Steal the upload/download from the flashing utils?
- Install script
- (Mostly joking) Alternative reading & writing method if there's no focal port but there's a setup for it. Will require a bunch of docs and some hexcasting stuff. But doable enough? Though much more annoying to do without Hexbound's pattern editing (and will limit to drawable patterns (maybe?))
