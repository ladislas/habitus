// swift-tools-version: 6.0

import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        baseSettings: .settings(
            base: [
                "SWIFT_VERSION": "6.0",
                "SWIFT_STRICT_CONCURRENCY": "complete",
            ]
        )
    )
#endif

let package = Package(
    name: "Habitus",
    dependencies: []
)
