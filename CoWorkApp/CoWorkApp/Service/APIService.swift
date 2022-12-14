//
//  APIService.swift
//  CoWorkApp
//
//  Created by Alexandre Marcos on 22/08/2022.
//

import SwiftUI

class ApiService {
    static let URL = "http://localhost:8081"
    static var TOKEN = ""
    static var USER: User? = nil
    static var PLACE: [RentResponse] = []
    static var USER_RENT: [UserRentResponse] = []
    static var SUBLIST: [SubResponse] = []
    static let API_DEFAULT_RESPONSE: ApiResponse = ApiResponse(error: true, message: "An error has occured")
}

