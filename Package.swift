// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxTextureUI",
    platforms: [
      .iOS(.v11)
    ],
    products: [
        .library(
            name: "RxTextureUI",
            targets: ["RxTextureUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", exact: Version(6, 6, 0)),
        .package(url: "https://github.com/FluidGroup/TextureSwiftSupport", revision: "4fe38cfb8ab3a00fc9e792f4901955bc0ca711af")
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
