// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BestBuySearchApp",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(name: "AppCore", targets: ["AppCore"]),
        .library(name: "BestBuyClient", targets: ["BestBuyClient"]),
        .library(name: "Models", targets: ["Models"]),
        .library(name: "SearchFeature", targets: ["SearchFeature"]),
        .library(name: "ProductDetailFeature", targets: ["ProductDetailFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                "SearchFeature",
                "ProductDetailFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "SearchFeature",
            dependencies: [
                "Models",
                "BestBuyClient",
                "ProductDetailFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "ProductDetailFeature",
            dependencies: [
                "Models",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "BestBuyClient",
            dependencies: [
                "Models",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "Models",
            dependencies: []
        ),
        .testTarget(
            name: "ProductDetailFeatureTests",
            dependencies: ["ProductDetailFeature"]),
        .testTarget(
            name: "SearchFeatureTests",
            dependencies: [
                "SearchFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]),
    ]
)
