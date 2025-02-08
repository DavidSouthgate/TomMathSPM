// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TomMath",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v4)
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
                    "Package.swift",
                    "Headers",
                    "Tests",
                    "Vendor/demo",
                    "Vendor/doc",
                    "Vendor/etc",
                    "Vendor/logs",
                    "Vendor/mtest",
                    "Vendor/Package.swift",
                    "Vendor/s_mp_rand_platform.c",
                ],
                sources: [
                    "."
                ],
                publicHeadersPath: "Headers",
                cSettings: []),
        .testTarget(name: "TomMathTests",
                   dependencies: [
                        "TomMath"
                   ],
                   path: "Tests")
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
