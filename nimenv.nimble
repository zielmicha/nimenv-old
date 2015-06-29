[Package]
name          = "nimenv"
version       = "0.0.1"
author        = "Michał Zieliński <michal@zielinscy.org.pl>"
description   = "script to create isolated Nim environments"
license       = "MIT"

bin           = nimenv

[Deps]
Requires: "nim >= 0.11.2"
Requires: "nimble >= 0.6.0"
Requires: "docopt >= 0.6.1"
