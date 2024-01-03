//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Jorge Alejndro Marcial Galvan on 03/01/24.
//

import Foundation

class NetWorkManager{
    static let shared = NetWorkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init(){}
    
    func gerFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void){
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else{
            completed(nil, "This username created a invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error{
                completed(nil, "Unable to complete your request. Please check your intener connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else{
                completed(nil, "The data received form the server was invalid. Please try again.")
                return
            }
            
            //Decoder -> Taking the data form the server and decoding in to an object
            //Encoder -> Taking the object and converted to data
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //Try to decode and array of type Followers from data
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            }catch{
                completed(nil, "The data received form the server was invalid. Please try again.")
            }
        }
        
        task.resume()
    }
}
