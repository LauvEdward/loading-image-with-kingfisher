//
//"id": "0",
//        "author": "Alejandro Escamilla",
//        "width": 5616,
//        "height": 3744,
//        "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
//        "download_url": "https://picsum.photos/id/0/5616/3744"

import Foundation

class Image : Decodable {
    var id : String?
    var author : String?
    var width : Int?
    var height : Int?
    var url : String?
    var download_url : String?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case download_url = "download_url"
    }
}
