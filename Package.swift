// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "JGString",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "JGString",
            targets: ["JGString"]
        )
    ],
    targets: [
        .target(
            name: "JGString",
            path: "Pod/Classes"
        ),
        .testTarget(
            name: "JGStringTests",
            dependencies: ["JGString"],
            path: "Tests/JGStringTests"
        )
    ]
)
