// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NimbusPluginGPSLocation",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "NimbusPluginGPSLocation",
            targets: ["NimbusPluginGPSLocation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/salesforce/nimbus", .branch("master"))
    ],
    targets: [
        .target(
            name: "NimbusPluginGPSLocation",
            dependencies: ["Nimbus"],
            path: "platforms/ios/Sources/NimbusPluginGPSLocation"),
        ]
)
