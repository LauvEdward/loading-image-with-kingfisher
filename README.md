# TryTechnical
## 1. Cache image from url:
  Hầu hết mọi ứng dụng đều chứa một số loại đồ họa. Đó là lý do tại sao tải xuống và hiển thị hình ảnh trong ứng dụng di động là một trong những nhiệm vụ phổ biến    nhất đối với các nhà phát triển ứng dụng. Cuối cùng, nó có thể là một nguồn công việc không cần thiết khi ứng dụng tải lại các hình ảnh giống nhau nhiều lần.
  
  Trong bài viết này, tôi sẽ chỉ cách cải thiện nó bằng cách tạo Cache và tích hợp nó với load hình ảnh trong cell bằng cách sử dụng khung kết hợp.
  
  Tôi bắt đầu bằng một ứng dụng Load hình ảnh cơ bản và show nó lên:
  
  ![Imgur](https://i.imgur.com/Svb1U7F.png?1)
  
  Tôi sử dụng API free load 100 tấm hình từ picsum: https://picsum.photos/v2/list?page=2&limit=100
  
  Json trả về sẽ như vầy: 
  
        "id": "0",
        "author": "Alejandro Escamilla",
        "width": 5616,
        "height": 3744,
        "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
        "download_url": "https://picsum.photos/id/0/5616/3744"
  
  Json trả về sẽ chứa một đường link download_url để bạn có thể tải từng bức ảnh về hiện lên.
  Khi bạn đã gọi Json 100 bức ảnh về rồi, sẽ chứa các thông tin về bức ảnh như chiều dài, chiều rộng, tác giả,... và sau đó bạn phải đi load từng bức ảnh hiện lên thành một danh sách. Tôi dùng Collection view để hiện lên, mỗi khi bạn cuộn tới đâu thì mỗi cell phải gọi lần lượt download image từ URL và hiện lên, như thế sẽ làm cho App chúng ta rất chậm:
  
  ![Imgur](https://i.imgur.com/fXvw7gU.png)
  
  App sẽ liên tục phải gọi API URl để lưu các hình hảnh đó, bạn có thể thấy khi đo networking hiện tại là 7,8 MB/s, và nó làm cho App chúng ta rất chậm
  
  Vậy dùng Cache để Cache lại API như nào trong Swift:
   lấy image từ cache với key
   cachedVersion = cache.object(forKey: "CachedObject")
   gán image cache lại với key là cachedobject
   cache.setObject(image, forKey: "CachedObject")
  * Đầu tiên bạn khai báo một NSCache để lưu danh sách các hình ảnh:
  
   ```
   var cache : NSCache<NSString , UIImage> = {
    let imagecache = NSCache<NSString, UIImage>()
    return imagecache
    }()
   ```

* cache sẽ chứa các hình sách hình ảnh theo dạng [key : object] có nghĩa mỗi object sẽ được lưu với key riêng:

  ``` 
              if let imageURL = imageInfor?.download_url {
                    if let imageStatus = cache.object(forKey: imageURL as NSString) {
                        self.imageView.image = imageStatus
                        self.authorLabel.text = self.imageInfor?.author
                    } else {
                        let task = URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, response, error) in
                            if error != nil {
                                return
                            }
                            //let data = try? Data(contentsOf: imageURL)
                            let image = UIImage(data: data!)
                            cache.setObject(image!, forKey: imageURL as NSString, cost: (image?.pngData()!.count)!)
                            DispatchQueue.main.async {
                                self.imageView.image = image
                                self.authorLabel.text = self.imageInfor?.author
                            }
                        }
                        task.resume()
                    }
  ```
Anh em chỉ cần kiểm tra dùng lệnh if else để kiểm tra nếu ```if let imageStatus = cache.object(forKey: imageURL as NSString)``` cache image không bị trống thì ta tiến hành gán imageview bằng image chúng ta đã cache, ngược lại thì tiến hành load image và gán và cache.
Chúng ta kiếm tra lại xem khi tiến hành lướt lên lướt xuống:
![Imgur](https://i.imgur.com/fUqIp3Y.png)

Có thể thấy việc không gọi API liên tục làm cho app chúng ta trở nên mượt hơn khi load lại những hình ảnh đã lưu, nhưng bạn có thể thấy vì cache lại toàn bộ bức hình mà memory trở nên chiếm nhiều hơn.
