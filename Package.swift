// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(

    name: "aoc24",
    platforms: [
        .macOS(.v13)
    ],
    products: [
    .executable(
      name: "aoc24",
      targets: ["aoc24"])
  ],

    dependencies: [
    .package(url: "https://github.com/apple/swift-system", from: "1.4.0"),
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
  ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "aoc24",
            dependencies: [
                .product(name: "SystemPackage", package: "swift-system"),
                .product(name: "Algorithms", package: "swift-algorithms"),
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6),
            ]),
    ]
)
