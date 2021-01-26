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
Ở đây tôi custom lại lớp Collection view Datasource:
```
class ImageCollectionViewDataSource <CELL : UICollectionViewCell,T>: NSObject, UICollectionViewDataSource {
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
            self.cellIdentifier = cellIdentifier
            self.items =  items
            self.configureCell = configureCell
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        self.configureCell(cell as! CELL, items[indexPath.row])
        return cell
    }
}
```
+ Sử dụng: 
```
var imageViewModel : ImagesViewModel!
    var datasource : ImageCollectionViewDataSource<CellImage, Image>!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        imageViewModel = ImagesViewModel()
        imageViewModel.bindImageViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CellImage", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.datasource = ImageCollectionViewDataSource(cellIdentifier: "cell", items: imageViewModel.empData, configureCell: { (cell, image) in
            cell.configCellwithKingfisher(img: image)
        })
        DispatchQueue.main.async {
            self.collectionView.dataSource = self.datasource
            self.collectionView.reloadData()
        }
    }
```
