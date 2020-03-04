//
//  ImageDownload.swift
//  FlickrDemo
//
//  Created by haoshuai on 2020/3/4.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import Foundation
import UIKit
struct ImageDownloader {
    typealias ImageDownloaderCompletionHandler = (_ result: Result<UIImage,Error>) -> Void
    static let shared = ImageDownloader()
    
    let cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()
    
//    let tasks: [String : (URLSessionDataTask,ImageDownloaderCompletionHandler)] = [:]
    let tasks: NSMutableDictionary = NSMutableDictionary()
    let downloaderQueue: DispatchQueue
    
    let group = DispatchGroup()
    
    private let lock = NSLock()
    
    init() {
        
        cache.name = "onelcat.github.io.Image_Cache"
        
        downloaderQueue = DispatchQueue(label: "onelcat.github.io.downloaderQueue", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
        
        
    }
    
    func downloadImage(url: URL, completionHandler: @escaping ImageDownloaderCompletionHandler) {
        
        if let data = self.cache.object(forKey: url.absoluteString as NSString) {
            
            guard let image = UIImage(data: data as Data) else {
                fatalError()
            }
            
            debuglog("获取缓存数据")
            completionHandler(.success(image))
        }
        
        if let value = self.tasks[url.absoluteString] as? (URLSessionDataTask,ImageDownloaderCompletionHandler) {
            // 在任务中
            debuglog("还在下载任务",value.0)
            return
        }
        
        self.downloaderQueue.async {
            self.lock.lock()
            defer { self.lock.unlock() }
            let task = URLSession.shared.dataTask(with: url) { data, resopnd, error in
                
                if let error = error {
                    fatalError()
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    completionHandler(.failure(error!))
                    fatalError()
//                    return
                }
                
                
                if let key = resopnd?.url?.absoluteString,let value = self.tasks[key] as? (URLSessionDataTask,ImageDownloaderCompletionHandler) {
                    self.cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
//                    value.0.cancel()
                    self.tasks.removeObject(forKey: key)
                    DispatchQueue.main.async {
                        value.1(.success(image))
                    }
                    debuglog("在队列中回调")
                    return
                }
                
                DispatchQueue.main.async {
                    self.cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                    completionHandler(.success(image))
                    debuglog("直接返回")
                }
                
            } // task
            
            task.resume()
            
            self.tasks[url.absoluteString] = (task,completionHandler)
        } // downloaderQueue.async
        
        
        
    } // func
    
}
