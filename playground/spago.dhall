{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
    [ "console"
    , "effect"
    , "exceptions"
    , "foreign"
    , "foreign-generic"
    , "proxy"
    , "psci-support"
    , "quickcheck"
    , "spec"
    , "spec-quickcheck"
    , "unsafe-coerce"
    ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
