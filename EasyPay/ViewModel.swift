//
//  ViewModel.swift
//  EasyPay
//
//  Created by Vaishnavi on 12/12/24.
//

import Foundation

class ViewModel {
    
    var users: [User] = [] // Will hold the fetched data
    
    func fetchUsers(completion: @escaping () -> Void) { 
        let urlString = "https://api.github.com/users"
        guard let url = URL(string: urlString) else {
            print("Invalid url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Invalid url")
                return
            }
            
            guard let data = data else {
                print("Invalid url")
                return
            }
            
            // Parse the JSON response
            do {
                let decoder = JSONDecoder()
                self.users = try decoder.decode([User].self, from: data)
                print("The users is \(self.users.count)")
                DispatchQueue.main.async {
                    completion() // Notify the view controller that the data is ready
                }
            }
            catch {
                print("Invalid url")
            }
        }
        task.resume()
    }
}



