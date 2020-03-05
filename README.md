# 项目说明

> 裤说明:
- IGListKit: 集合元素管理
- Alamofire: 网络请求
- Kingfisher: 网络图片下载，以及网络图片缓存
- ObjectMapper: json字符串解析

这个项目工程下面有3个APP。每一个APP用到的裤有差别。并且对比3个APP之间的差距。

1. FlickrAPIExample APP: 会用到`IGListKit`,`Alamofire`,`Kingfisher`,`Kingfisher`,`ObjectMapper`第三方的裤。

2. FlickrDemo: 只用到`ObjectMapper`裤。会在主界面出现图片渲染混乱的错误。

## 第三方依赖


# FlickrAPIExample




## 项目说明

> 项目导入了3个第三方库

- Kingfisher(网络图片相关): 图片缓存，图片多线程下载
- ObjectMapper(JSON解析相关): JSON字符串解析


-----

### 网络请求部分

> 自己实现: 对于这个项目简单的时间就可以达到要求。

```swift
func request(url: URL,completionHandler: @escaping (_ result: Result<String,Error>) -> Void) {
    
    // 这个项目暂时不需要高并发
    
    let queue = DispatchQueue(label: "onelcat.github.io request json Queue")
    
    queue.async {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    assert(false)
                    completionHandler(.failure(error))
                    return
                }
                guard let value = data,let string = String(data: value, encoding: String.Encoding.utf8) else {
                    assert(false)
                    let error = NSError(domain: "onelcat.github.io encoding uft-8 error", code: 10001, userInfo: nil)
                    completionHandler(.failure(error))
                    return
                }
                completionHandler(.success(string))
            } // DispatchQueue.main.async
        
        } // URLSession
        
        task.resume()
    }

}
```
