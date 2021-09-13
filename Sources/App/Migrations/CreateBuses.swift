//
//  CreateBuses.swift
//  Shuttle Tracker Server
//
//  Created by Gabriel Jacoby-Cooper on 9/21/20.
//

import Fluent

struct CreateBuses: Migration {
	
	func prepare(on database: Database) -> EventLoopFuture<Void> {
		return database.schema(Bus.schema)
			.id()
			.field("locations", .array(of: .custom(Bus.Location.self)), .required)
			.field("congestion", .dictionary, .required)
			.create()
	}
	
	func revert(on database: Database) -> EventLoopFuture<Void> {
		return database.schema(Bus.schema)
			.delete()
	}
	
}
