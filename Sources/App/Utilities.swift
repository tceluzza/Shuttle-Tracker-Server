//
//  Utilities.swift
//  Shuttle Tracker Server
//
//  Created by Gabriel Jacoby-Cooper on 8/27/21.
//

import Foundation
import Vapor
import Fluent

enum Constants {
	
	/// The current version number for the API.
	///
	/// Increment this value every time a breaking change is made to the public-facing API.
	static let apiVersion: UInt = 1
	
	static let datafeedURL: URL = {
		if let itrakString = ProcessInfo.processInfo.environment["ITRAK"] {
			return URL(string: itrakString)!
		} else {
			return URL(string: "https://shuttletracker.app/datafeed")!
		}
	}()
	
}

enum CoordinateUtilities {
	
	static let centerLatitude = 42.735
	
}

enum CryptographyUtilities {
	
	static func verify(signature signatureData: Data, of contentData: Data) throws -> Bool {
		guard let keysDirectoryPath = ProcessInfo.processInfo.environment["KEYS_DIRECTORY"] else {
			throw Abort(.internalServerError)
		}
		let keyFilePaths = try FileManager.default.contentsOfDirectory(atPath: keysDirectoryPath)
			.filter { (filePath) in
				return filePath.hasSuffix(".pem")
			}
		let keysDirectoryURL = URL(fileURLWithPath: keysDirectoryPath, isDirectory: true)
		for keyFilePath in keyFilePaths {
			let keyFileURL = keysDirectoryURL.appendingPathComponent(keyFilePath)
			let publicKey: P256.Signing.PublicKey
			let signature: P256.Signing.ECDSASignature
			do {
				let keyFileContents = try String(contentsOfFile: keyFileURL.path)
				publicKey = try P256.Signing.PublicKey(pemRepresentation: keyFileContents)
				signature = try P256.Signing.ECDSASignature(rawRepresentation: signatureData)
			} catch {
				continue
			}
			if publicKey.isValidSignature(signature, for: contentData) {
				return true
			}
		}
		return false
	}
	
}

extension Optional: Content, RequestDecodable, ResponseEncodable, AsyncRequestDecodable, AsyncResponseEncodable where Wrapped: Codable { }

extension Set: Content, RequestDecodable, ResponseEncodable, AsyncRequestDecodable, AsyncResponseEncodable where Element: Codable { }

extension Collection where Element: Model {
	
	/// Saves each model object in this collection.
	/// - Parameter database: The database on which to save the model objects.
	func save(on database: Database) async throws {
		for object in self {
			try await object.save(on: database)
		}
	}
	
}
