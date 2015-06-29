import nimble
import os, osproc, docopt, strutils

const doc = """
nimenv multicall binary

When invoked via `nimble` symlink, run Nimble package manager.
When invoked via some other name:

Creates isolated Nim enviroments.

Usage:
  nimenv <path>

Options:
  -h --help     Show this screen.
  --version     Shows version.
"""

const activateScript = staticRead("activate")

proc isEmpty(path: string): bool =
  for _ in walkDir(path):
    return false
  return true

proc install(path: string) =
  echo "creating nimenv at $1..." % [path]

  if existsDir(path) and not isEmpty(path):
    raise newException(Exception, "$1 already exists and is not empty" % [path])

  if not existsDir(path):
    createDir(path)

  createDir(path / "bin")
  writeFile(path / "bin" / "activate",
            activateScript
              .replace("[[path]]", path.quoteShellPosix)
              .replace("[[name]]", path.splitPath.tail.quoteShellPosix))
  createSymlink(getApplicationFilename(), path / "bin" / "nimble")

proc main() =
  let args = docopt(doc, version="Nimenv 0.1")
  let path = $(args["<path>"])
  install(path)

when isMainModule:
  let binaryName = paramStr(0).splitPath.tail
  if binaryName == "nimble":
    nimble.main()
  else:
    nimenv.main()
