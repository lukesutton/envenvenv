# EnvEnvEnv

A Swift library for typed access to environment variables.

## An Example

```swift
import EnvEnvEnv

let env = Env()
let path = env["PATH"].string
```

The above returns an optional string.

## Supported Types

* Int
* String
* Double
* Bool
