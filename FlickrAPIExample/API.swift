//
//  API.swift
//  FlickrAPIExample
//
//  Created by haoshuai on 2020/3/3.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import Alamofire
import ObjectMapper


struct API {
    
    private let API_KEY = "475486054f5b1afa16fefe55415fa546"
    
    static let shared = API()
    
    private let root_url = "https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=475486054f5b1afa16fefe55415fa546&format=json&nojsoncallback=1"
    
//    private var dataSource: PhotosModel?
    
    init() { }
    
    // 时间格式化
    
    
    func interestingnessGetList(date: Date = Date(),page: Int = 1,per_page: Int = 200,completionHandler: @escaping (_ result: Result<PhotosModel,Error>) -> Void) {

        let yesterdays = Date(timeIntervalSince1970: date.timeIntervalSince1970 - 2*86400)
        
        let url = root_url + "&date=\(yesterdays.dateFormat(formatter: "yyyy-MM-dd"))" + "&page=\(page)&per_page=\(per_page)" + "&extras=description,date_upload,owner_name"

        AF.request(url).responseString { (resultData) in
            
            switch resultData.result {
            case let .success(value):
                
                if let result = Mapper<ResultModel>().map(JSONString: value) {
                    if result.code == 0,let photos = result.photos  {
                        completionHandler(.success(photos))
                    } else {
                        let error = NSError(domain: result.message, code: result.code, userInfo: nil)
                        completionHandler(.failure(error))
                    }
                } else {
                    let error = NSError(domain: "io.onelcat.github mapper is null", code: 100036, userInfo: nil)
                    completionHandler(.failure(error))
                }
                
            case let .failure(error):
                debuglog("请求失败",error.errorDescription ?? "一个未知错误")
            } // switch resultData.result
            
        } // AF.request(url).responseString
        
    }// func
    
//    s    小正方形 75x75
//    q    large square 150x150
//    t    縮圖，最長邊為 100
//    m    小，最長邊為 240
//    n    small, 320 on longest side
//    -    中等，最長邊為 500
//    z    中等尺寸 640，最長邊為 640
//    c    中等尺寸 800，最長邊為 800†
//    b    大尺寸，最長邊為 1024*
//    h    大型 1600，長邊 1600†
//    k    大型 2048，長邊 2048†
//    o    原始圖片, 根據來源格式可以是 jpg、gif 或 png
//    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
//        or
//    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
//        or
//    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{o-secret}_o.(jpg|gif|png)
    
    static func photoModelTransformToImageURL(_ photo: PhotoModel) -> URL {
        let url = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        return URL(string: url)!
    }
    
}
