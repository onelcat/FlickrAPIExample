//
//  Networking.swift
//  FlickrDemo
//
//  Created by haoshuai on 2020/3/4.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import Alamofire
import ObjectMapper
import UIKit

struct API {
    
    private let API_KEY = "475486054f5b1afa16fefe55415fa546"
    
    static let shared = API()
    
    private let root_url = "https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=475486054f5b1afa16fefe55415fa546&format=json&nojsoncallback=1"
    
    init() { }
    
    func getPhotoInfo(photo: PhotoModel) {
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=475486054f5b1afa16fefe55415fa546&photo_id=\(photo.id)&secret=\(photo.secret)&format=json&nojsoncallback=1"
        AF.request(url).responseString { (resultData) in
            switch resultData.result {
            case let .success(value):
                debuglog("请求成功",value)
            case let .failure(error):
                debuglog("请求失败",error.localizedDescription)
            }
        }
    }
    
    func getPhotoSize(photo: PhotoModel) {
        let url = "https://www.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=475486054f5b1afa16fefe55415fa546&photo_id=\(photo.id)&format=json&nojsoncallback=1"
        
        AF.request(url).responseString { (resultData) in
            switch resultData.result {
            case let .success(value):
                debuglog("请求成功",value)
            case let .failure(error):
                debuglog("请求失败",error.localizedDescription)
            }
        }
        
    }
    
    
    
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
    
    static func sizeTransformToType(width: CGFloat) -> String {
        if width <= 75.0 {
            return "_s"
        }
        else if width <= 100.0 {
            return "_t"
        }
        else if width <= 150.0 {
            return "_q"
        }
        else if width <= 240.0 {
            return "_m"
        }
        else if width <= 320.0 {
            return "_n"
        }
        else if width <= 500.0 {
            return ""
        }
        else if width <= 640.0 {
            return "_z"
        }
        else if width <= 800.0 {
            return "_c"
        }
        return "_b"
    }
    
    static func photoModelTransformToImageURL(_ photo: PhotoModel,itemSize: CGSize) -> URL {
        let type = sizeTransformToType(width: itemSize.width * UIScreen.main.scale)
        let farm = photo.farm == 0 ? 66 : photo.farm
        let url = "https://farm\(farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)\(type).jpg"
        return URL(string: url)!
    }
    
    
//    func request(_ url: String) {
//        URLSession.shared.dataTask(with: URL.init(string: url)!) { (data, _, error) in
//            guard let value = data else {
//                fatalError()
//            }
//            let jsonStr = String(data: value, encoding: String.Encoding.utf8)
//        }
//    }
}
