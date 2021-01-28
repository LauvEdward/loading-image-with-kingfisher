//
//  APIServiceImage.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/26/21.
//

import Foundation
import Alamofire
class APIServiceImage {
    static let shared = APIServiceImage()
    func fetchImageAlamorefire(completion : @escaping ([Image]) -> Void) {
        AF.request("https://picsum.photos/v2/list?page=2&limit=100").responseJSON { (data) in
            switch data.result {
            case .success(_):
                do {
                    let listimage = try JSONDecoder().decode([Image].self, from: data.data!)
                    completion(listimage)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("request error: \(error.localizedDescription)")
            }
        }
    }
}
