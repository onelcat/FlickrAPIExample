//
//  InfoViewController.swift
//  FlickrDemo
//
//  Created by haoshuai on 2020/3/4.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import UIKit
import WebKit

final class InfoViewController: UIViewController {

    var dataSource: PhotoModel?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionView: WKWebView!
    
    private var task: URLSessionDataTask?
    
    private var downloadedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let value = self.dataSource else {
            fatalError("数据错误")
        }
        self.title = value.title
        
        let url = value.getImageURL(size: CGSize(width: self.view.bounds.width, height: self.view.bounds.width))
        
        task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                return print("Error downloading \(url): " + String(describing: error))
            }
            
            DispatchQueue.main.async {
                self.downloadedImage = image
                self.imageView.image = self.downloadedImage
            }
        }
        
        task?.resume()
        self.nameLabel.text = "作者: " + value.ownername
        self.dateLabel.text = "日期: " + value.dateupload

        self.descriptionView.navigationDelegate = self
        self.descriptionView.loadHTMLString(value.description ?? "", baseURL: nil)
        
        // Do any additional setup after loading the view.
    }
    
}

extension InfoViewController: WKUIDelegate,WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let jsStr = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '180%'"
        self.descriptionView.evaluateJavaScript(jsStr) { (evaluation, erro) in
            
        }
    }
}
