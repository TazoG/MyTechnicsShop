//
//  NetworkService.swift
//  TechnicsShop
//
//  Created by Tazo Gigitashvili on 12.09.22.
//

import Foundation

class NetworkService {
    
    static var shared = NetworkService()
    
    func getData(completion: @escaping (ProductsData)->()) {
        let url = URL(string: "https://dummyjson.com/products")!
        let urlReq = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlReq) { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
      
            guard let response = response as? HTTPURLResponse else {
                print("no response")
                return
            }

            guard (200...300).contains(response.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                let postsData = try JSONDecoder().decode(ProductsData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(postsData)
                }
            } catch {
                print(error)
            }
        }.resume()
    
    }
}
