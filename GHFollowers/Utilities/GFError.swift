//
//  GFError.swift
//  GHFollowers
//
//  Created by Jorge Alejndro Marcial Galvan on 13/01/24.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created a invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your intener connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received form the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alradyInFavorites = "You've already favorited this user."
}
