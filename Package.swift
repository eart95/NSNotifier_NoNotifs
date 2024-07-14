// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "NightscoutNotifier",
    products: [
        .executable(
            name: "NightscoutNotifier",
            targets: ["NightscoutNotifier"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/IBM-Swift/Swift-JWT.git", from: "3.6.1"),
    ],
    targets: [
        .target(
            name: "NightscoutNotifier",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "SwiftJWT", package: "Swift-JWT"),
            ],
            path: "Sources/NightscoutNotifier",
            cSettings: [
                .headerSearchPath("usr/include"),
                .define("OPENSSL", to: "1")
            ]
        ),
        .target(
            name: "OpenSSL",
            path: "Sources/OpenSSL",
            publicHeadersPath: "include"
        ),
        .testTarget(
            name: "NightscoutNotifierTests",
            dependencies: ["NightscoutNotifier"],
            path: "Tests/NightscoutNotifierTests"
        ),
    ]
)
