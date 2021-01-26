# TryTechnical
## 1. Xây dựng MVVM:
Mô hình MVVM chú ý:
+ các đối tượng sẽ do một lớp API gọi và trả về:
```
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
```
API này sẽ trả về một danh sách các hình ảnh, list hình ảnh
+ Lớp ModelView: lớp này sẽ làm nhiệm vụ bắt sự kiện và chuyển image lên cho view
```
class ImagesViewModel : NSObject{
    private var apiServiceImage : APIServiceImage!
    var empData : [Image]! {
        didSet {
            self.bindImageViewModelToController()
        }
    }
    var bindImageViewModelToController : (() -> ()) = {}
    override init() {
        super.init()
        apiServiceImage = APIServiceImage()
        callFunctoGetEmpData()
    }
    
    func callFunctoGetEmpData() {
        self.apiServiceImage.fetchImageAlamorefire { (listimage) in
            self.empData = listimage
        }
    }
}
```
