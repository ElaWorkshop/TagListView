// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "TagListView",
                      platforms: [.iOS(.v9)],
                      products: [.library(name: "TagListView",
                                          targets: ["TagListView"])],
                      targets: [.target(name: "TagListView",
                                        path: "TagListView")],
                      swiftLanguageVersions: [.v5])
