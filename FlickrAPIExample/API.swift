//
//  API.swift
//  FlickrAPIExample
//
//  Created by haoshuai on 2020/3/3.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import Alamofire

struct API {
    private let API_KEY = "475486054f5b1afa16fefe55415fa546"
    
    static let shared = API()
    
    private let root_url = "https://www.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=475486054f5b1afa16fefe55415fa546&format=json&nojsoncallback=1"
    
    
    init() { }
    
    // 时间格式化
    
    
    func interestingnessGetList(date: Date = Date()) {
        let yesterdays = date.timeIntervalSince1970 - 24 * 60 * 60
        let yes = Date(timeIntervalSince1970: yesterdays)
        
        let url = root_url + "&date=\(yes.dateFormat(formatter: "yyyy-MM-dd"))" + "&extras=description,date_upload,owner_name"
        debuglog("请求地址",url)
        AF.request(url, method: .get, headers: nil, interceptor: nil).responseJSON(queue: DispatchQueue.global()) { (resultData) in
            switch resultData.result {
            case let .success(value):
                debuglog("请求成功",value)
            case let .failure(error):
                debuglog("请求失败",error.errorDescription ?? "一个未知错误")
            }
        }
    }
}
