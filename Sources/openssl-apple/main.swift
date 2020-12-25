import Foundation
import FMake

OutputLevel.default = .error

try sh("./build-libssl.sh")

try sh("./create-openssl-framework.sh static")

try cd("xcframeworks/static") {
    try sh("zip -r ../../openssl-static.xcframework.zip openssl.xcframework")
}

try sh("zip -r openssl-libs.zip libs")

try sh("./create-openssl-framework.sh dynamic")

try cd("xcframeworks/dynamic") {
    try sh("zip -r ../../openssl-dynamic.xcframework.zip openssl.xcframework")
}

try cd("frameworks/static") {
    try sh("zip -r ../../openssl-static.frameworks.zip .")
}

try cd("frameworks/dynamic") {
    try sh("zip -r ../../openssl-dynamic.frameworks.zip .")
}

let releaseMD =
  """

    | File                            | MD5                                                 |
    | ------------------------------- |:---------------------------------------------------:|
    | openssl-static.xcframework.zip  | \(try md5(path: "openssl-static.xcframework.zip"))  |
    | openssl-dynamic.xcframework.zip | \(try md5(path: "openssl-dynamic.xcframework.zip")) |
    | openssl-static.frameworks.zip   | \(try md5(path: "openssl-static.frameworks.zip"))   |
    | openssl-dynamic.frameworks.zip  | \(try md5(path: "openssl-dynamic.frameworks.zip"))  |

  """

try write(content: releaseMD, atPath: "release.md")
