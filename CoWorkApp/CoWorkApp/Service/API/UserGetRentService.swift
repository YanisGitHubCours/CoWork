//
//  UserSignUpService.swift
//  CoWorkApp
//
//  Created by Alexandre Marcos on 22/08/2022.
//

import SwiftUI


class UserGetRentService {
    class func Rent(id_place: String, id_schedule: String, completion: @escaping (ApiResponse) -> Void){
        guard let url = URL(string: ApiService.URL + "/createRent") else {
            completion(ApiResponse(error: true, message: "Cannot access URL"))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(ApiService.TOKEN, forHTTPHeaderField: "Authorization")
        var dataArray:[String:Any] = [:]
        
        dataArray["fk_user"] = ApiService.USER!.id
        dataArray["fk_pls"] = id_schedule
        dataArray["fk_place"] = id_place
        
        let datas = try? JSONSerialization.data(withJSONObject: dataArray, options: .fragmentsAllowed)
        urlRequest.httpBody = datas
        
        let req = URLSession.shared.dataTask(with: urlRequest) { (datas, res, err)  in
            guard err == nil, let _ = datas else {
                completion(ApiResponse(error: true, message: "Error during process"))
                return
            }
        
            
            completion(ApiResponse(error: false, message: "Ok"))
            
        }
        req.resume()
    }
}
