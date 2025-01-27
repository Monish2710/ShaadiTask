//
//  UserResponse.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//
import Foundation

// MARK: DataModel

struct UserResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let picture: Picture
}

struct Name: Codable {
    let title, first, last: String
}

struct Location: Codable {
    let street: Street
    let city, state, country: String
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Login: Codable {
    let uuid, username, password: String
}

struct DateOfBirth: Codable {
    let date: String
    let age: Int
}

struct ID: Codable {
    let name, value: String
}

struct Picture: Codable {
    let large, medium, thumbnail: String
}

struct UserDomainModel {
    let name: String
    let profilePictureURL: String
    let location: String
    let isAccepted: Bool
    let isDeclined: Bool
    let email: String
}


