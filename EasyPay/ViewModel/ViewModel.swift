//
//  ViewModel.swift
//  EasyPay
//
//  Created by Vaishnavi on 12/12/24.
//

import Foundation

class ViewModel {
    
    var users: [User] = []
    private var currentPage = 1
    private var isLoading = false
    private let totalPages = 5
    
    func fetchUsers(page: Int, completion: @escaping ([User]?, Bool) -> Void) {
        let itemsPerPage = 5 * page
        let urlString = "https://api.github.com/users?per_page=\(itemsPerPage)&page=\(page)"
        guard let url = URL(string: urlString) else {
            print("Invalid url")
            completion(nil, false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading data: \(error.localizedDescription)")
                completion(nil, false)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil, false)
                return
            }
            
            // JSON response Parsing
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(users, page <= self.totalPages)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil, false)
            }
        }
        task.resume()
    }
}




