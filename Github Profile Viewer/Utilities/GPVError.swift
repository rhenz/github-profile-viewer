//
//  ErrorMessage.swift
//  Github Profile Viewer
//
//  Created by John Salvador on 6/20/22.
//

import Foundation

enum GPVError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
