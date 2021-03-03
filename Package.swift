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
        .package(url: "https://gitee.com/4674069/ObjectMapper.git", .upToNextMajor(from: "4.2.0")),
        .package(url: "https://gitee.com/4674069/MBProgressHUD.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://gitee.com/4674069/RxSwift.git", .exact("5.1.1")),
        .package(url: "https://gitee.com/4674069/Eureka.git", .upToNextMajor(from: "5.3.2")),
        .package(url: "https://gitee.com/4674069/ReactiveSwift.git", .upToNextMajor(from: "6.1.0")),
        .package(url: "https://gitee.com/4674069/Alamofire.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://gitee.com/4674069/Moya.git", .branch("YZY"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "EGKit",
            dependencies: ["EGServer", "MBProgressHUD", "EGRefresh", "EGUtils", "Eureka"]),
        .target(
            name: "EGServer",
            dependencies: [.product(name: "RxMoya", package: "Moya"), .product(name: "RxCocoa", package: "RxSwift"), "ObjectMapper", "Cache"]),
        .target(
            name: "Cache",
            dependencies: []),
        .target(
            name: "EGRefresh",
            dependencies: []),
        .target(
            name: "EGUtils",
            dependencies: []),
        .testTarget(
            name: "EGKitTests",
            dependencies: ["EGKit", "EGServer", "EGRefresh"]),
    ]
)
