// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TomMath",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9)
    ],
    products: [
        .library(
            name: "TomMath",
            targets: [ "TomMath" ])
    ],
    dependencies: [],
    targets: [
        .target(name: "TomMath",
                path: ".",
                exclude: [
                    "vendor/demo",
                    "vendor/doc",
                    "vendor/etc",
                    "vendor/logs",
                    "vendor/mtest",
                    "vendor/Package.swift",
                ],
                sources: [
                    "vendor"
                ],
                publicHeadersPath: "Headers",
                cSettings: [
                    .unsafeFlags(["-flto=thin"])  // for Dead Code Elimination
                ]),
        .testTarget(name: "TomMathTests",
                   dependencies: [
                        "TomMath"
                   ],
                   path: "Tests")
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
