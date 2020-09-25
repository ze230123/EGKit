// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EGKit",
    platforms: [.iOS(.v10)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "EGKit",
            targets: ["EGKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://github.com/jdg/MBProgressHUD.git", .upToNextMajor(from: "1.2.0")),
        .package(name: "GRDB", url: "https://github.com/groue/GRDB.swift.git", .upToNextMajor(from: "5.0.0-beta.11"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "EGKit",
            dependencies: ["EGServer", "MBProgressHUD", "EGRefresh"]),
        .target(
            name: "EGServer",
            dependencies: [.product(name: "RxMoya", package: "Moya"), "ObjectMapper", "Record", "Cache"]),
        .target(
            name: "Record",
            dependencies: ["GRDB"]),
        .target(
            name: "Cache",
            dependencies: []),
        .target(
            name: "EGRefresh",
            dependencies: []),
        .testTarget(
            name: "EGKitTests",
            dependencies: ["EGKit", "EGServer", "EGRefresh"]),
    ]
)
