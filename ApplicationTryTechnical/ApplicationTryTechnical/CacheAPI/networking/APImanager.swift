//
//  APImanager.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/19/21.
//

import Foundation
class APImanager {
    static let shared = APImanager()
    func fetchImage(completion : @escaping ([Image]) -> Void) {
        let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=100")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("error load image")
                return
            }
            if let data = data {
                let listimage : [Image] = try! JSONDecoder().decode([Image].self, from: data)
                completion(listimage)
            }
        }
        task.resume()
    }
}
