//
//  DataSourceModel.swift
//  FlickrAPIExample
//
//  Created by haoshuai on 2020/3/3.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import ObjectMapper
import IGListKit

struct ResultModel: Mappable  {
    
    var photos: PhotosModel? = nil
    var stat: String = "OK"
    var message: String = "success"
    var code: Int = 0
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.photos <- (map["photos"])
        self.stat <- (map["stat"])
        self.message <- (map["message"])
        self.code <- (map["code"])
    }
}

struct PhotosModel: Mappable {
    
    var page: Int = 0
    var pages: Int = 0
    var perpage: Int = 0
    var total: Int = 0
    var photo: [PhotoModel] = []
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.page <- (map["page"])
        self.pages <- (map["pages"])
        self.perpage <- (map["perpage"])
        self.total <- (map["total"])
        self.photo <- (map["photo"])
    }
    

}

class PhotoModel: Mappable,ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? PhotoModel else { return false }
        return self.id == object.id
    }
    

    
    var id: String = ""
    var farm: Int = -1
    var server: String = ""
    var secret: String = ""
    var dateupload: String = Date().dateFormat(formatter: "yyyy-MM-dd")
    var title: String = ""
    var ownername: String = ""
    var description: String? = nil
    
    
    var imageURL: URL {
        return API.photoModelTransformToImageURL(self)
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- (map["id"])
        self.farm <- (map["farm"])
        self.server <- (map["server"])
        self.secret <- (map["secret"])
        self.dateupload <- (map["dateupload"],DateStringTransformString())
        self.title <- (map["title"])
        self.ownername <- (map["ownername"])
        self.description <- (map["description"],DescriptionTransform())
    }
    
}

struct DateStringTransformString: TransformType{
    func transformFromJSON(_ value: Any?) -> String? {
        guard let value = value as? String,let sc = Int(value) else {
            fatalError()
        }
        return Date(timeIntervalSince1970: TimeInterval(sc)).dateFormat(formatter: "yyyy-MM-dd")
    }
    
    func transformToJSON(_ value: String?) -> String? {
        fatalError()
    }
    
    typealias Object = String
    
    typealias JSON = String
    
    
}

struct DescriptionTransform:TransformType {
    
    func transformFromJSON(_ value: Any?) -> String? {
//        debuglog("解析范本",value ?? "❌")
        if let value = value as? [String : String] {
//            debuglog("解析出来的结果", value["_content"] ?? "🈚️")
            return value["_content"]
        }
        return "结果"
    }
    
    func transformToJSON(_ value: String?) -> [String : Any]? {
        fatalError("这里不会掉用到")
    }
    
    typealias Object = String
    
    typealias JSON = [String : Any]
    
    
}
