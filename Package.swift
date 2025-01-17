// swift-tools-version:5.7

import PackageDescription

let package = Package(
	name: "Shuttle Tracker Server",
	platforms: [
		.macOS(.v12)
	],
	dependencies: [
		.package(
			url: "https://github.com/vapor/vapor.git",
			from: "4.65.0"
		),
		.package(
			url: "https://github.com/vapor/queues.git",
			from: "1.8.0"
		),
		.package(
			url: "https://github.com/vapor/fluent.git",
			from: "4.4.0"
		),
		.package(
			url:"https://github.com/vapor/fluent-sqlite-driver.git",
			from: "4.0.0"
		),
		.package(
			url: "https://github.com/vapor/fluent-postgres-driver.git",
			from: "2.2.0"
		),
		.package(
			url: "https://github.com/m-barthelemy/vapor-queues-fluent-driver.git",
			from: "1.0.0"
		),
		.package(
			url: "https://github.com/malcommac/UAParserSwift.git",
			from: "1.2.0"
		),
		.package(
			url: "https://github.com/mapbox/turf-swift.git",
			from: "2.2.0"
		),
		.package(
			url: "https://github.com/Gerzer/JSONParser.git",
			from: "1.3.0"
		),
		.package(
			url: "https://github.com/Gerzer/CoreGPX.git",
			revision: "6ef3abe863a82a3be7552734f20080749554eae1"
		)
	],
	targets: [
		.target(
			name: "App",
			dependencies: [
				.product(
					name: "Vapor",
					package: "vapor"
				),
				.product(
					name: "Queues",
					package: "queues"
				),
				.product(
					name: "Fluent",
					package: "fluent"
				),
				.product(
					name: "FluentSQLiteDriver",
					package: "fluent-sqlite-driver"
				),
				.product(
					name: "FluentPostgresDriver",
					package: "fluent-postgres-driver"
				),
				.product(
					name: "QueuesFluentDriver",
					package: "vapor-queues-fluent-driver"
				),
				.product(
					name: "CoreGPX",
					package: "CoreGPX"
				),
				.product(
					name: "JSONParser",
					package: "JSONParser"
				),
				.product(
					name: "UAParserSwift",
					package: "UAParserSwift"
				),
				.product(
					name: "Turf",
					package: "turf-swift"
				)
			]
		),
		.executableTarget(
			name: "Runner",
			dependencies: [
				.target(name: "App")
			]
		)
	]
)
