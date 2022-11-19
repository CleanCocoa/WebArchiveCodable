// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "WebArchiveCodable",
    platforms: [.macOS(.v10_10), .iOS(.v13)],
    products: [
        .library(
            name: "WebArchiveCodable",
            targets: ["WebArchiveCodable"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WebArchiveCodable",
            dependencies: []),
        .testTarget(
            name: "WebArchiveCodableTests",
            dependencies: ["WebArchiveCodable"],
            resources: [
              .copy("Fixtures"),
            ]),
    ]
)
