// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxTextureUI",
    platforms: [
      .iOS(.v13)
    ],
    products: [
        .library(
            name: "RxTextureUI",
            targets: ["RxTextureUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", exact: Version(6, 7, 0)),
        .package(url: "https://github.com/FluidGroup/TextureSwiftSupport", exact: Version(3, 20, 1))
    ],
    targets: [
        .target(
            name: "RxTextureUI",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "TextureSwiftSupport", package: "TextureSwiftSupport")
            ]
        ),
        .testTarget(
            name: "RxTextureUITests",
            dependencies: [
                "RxTextureUI",
                .product(name: "RxTest", package: "RxSwift")
            ]
        )
    ]
)
