//
//  ImageDownload.swift
//  FlickrDemo
//
//  Created by haoshuai on 2020/3/4.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import Foundation
import UIKit

typealias ImageDownloaderCompletionHandler = (_ result: Result<UIImage,Error>) -> Void

final class SessionDoneTask {
    let dataTask: URLSessionDataTask
    let callback: ImageDownloaderCompletionHandler
    init(_ dataTask: URLSessionDataTask,_ callback: @escaping ImageDownloaderCompletionHandler) {
        self.dataTask = dataTask
        self.callback = callback
    }
}

struct ImageDownloader {
    
    static let shared = ImageDownloader()
    
    private let cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()
    
    // url : SessionDoneTask

    private let tasks: NSMutableDictionary = NSMutableDictionary()
    
    func add(
        _ dataTask: URLSessionDataTask,
        url: URL,
        callback: @escaping ImageDownloaderCompletionHandler) -> Int
    {
        lock.lock()
        defer { lock.unlock() }
        let done = SessionDoneTask(dataTask, callback)
        self.tasks.setValue(done, forKey: url.absoluteString)
        return self.tasks.count
    }

    // 查看任务
    func task(for url: URL) -> SessionDoneTask? {
        lock.lock()
        defer { lock.unlock() }
        guard let task = self.tasks[url.absoluteString] as? SessionDoneTask  else {
            return nil
        }
        return task
    }
    
    // 任务取消
    func cancel(url: URL) {
        lock.lock()
        guard let task = self.tasks.value(forKey: url.absoluteString) as? SessionDoneTask  else {
            return
        }
        task.dataTask.cancel()
        lock.unlock()
    }
    
    func remove(url: URL) {
        lock.lock()
        defer { lock.unlock() }
        guard let task = self.tasks.value(forKey: url.absoluteString) as? SessionDoneTask  else {
            return
        }
//        task.dataTask.cancel()
        self.tasks.removeObject(forKey: url.absoluteString)
//        lock.unlock()
    }
    
    private let downloaderQueue: DispatchQueue
    
    private let group = DispatchGroup()
    
    private let lock = NSLock()
    
    init() {
        
        cache.name = "onelcat.github.io.Image_Cache"
        
        downloaderQueue = DispatchQueue(label: "onelcat.github.io.downloaderQueue", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
        
        
    }
    
    func downloadImage(url: URL, completionHandler: @escaping ImageDownloaderCompletionHandler) {
        
        if let data = self.cache.object(forKey: url.absoluteString as NSString) {
            debuglog("获取缓存数据",url)
            guard let image = UIImage(data: data as Data) else {
                fatalError()
            }
            self.remove(url: url)
            completionHandler(.success(image))
            return
        }
        
        
        if let task = self.task(for: url) {
            // 任务在进行中
            debuglog("任务在进行中",url,task)
            return
        }
        
        
        
        self.downloaderQueue.async {

            let task = URLSession.shared.dataTask(with: url) { data, resopnd, error in
                
                if let error = error {
                    fatalError(error.localizedDescription)
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    fatalError()
                }
                
                if let key = resopnd?.url,let task = self.task(for: key) {
                    self.cache.setObject(data as NSData, forKey: key.absoluteString as NSString)
                    self.remove(url: key)
                    debuglog("从任务队列返回数据",key.absoluteString == url.absoluteString,url)
                    DispatchQueue.main.async {
                        task.callback(.success(image))
                    }
                    return
                } else {
                    debuglog("抛弃任务")
                }
                
                DispatchQueue.main.async {
                    debuglog("直接返回❌❌❌❌❌",url.absoluteString)
                    self.cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                    completionHandler(.success(image))
                }
                
            } // task
            
            task.resume()
            let workCount = self.add(task, url: url, callback: completionHandler)
            debuglog("需要执行的任务",workCount)
        } // downloaderQueue.async
        
        
        
    } // func
    
}
