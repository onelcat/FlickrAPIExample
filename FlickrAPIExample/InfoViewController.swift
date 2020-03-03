//
//  InfoViewController.swift
//  FlickrAPIExample
//
//  Created by haoshuai on 2020/3/3.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import UIKit

final class InfoViewController: UIViewController {

    var dataSource: PhotoModel? {
        didSet {
        
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       guard let value = self.dataSource else {
            fatalError("数据错误")
        }
            
        self.imageView.kf.setImage(with: value.imageURL)
        self.nameLabel.text = "作者: " + value.ownername
        self.dateLabel.text = "日期: " + value.dateupload
        self.descriptionTextView.text = value.description
    
        // Do any additional setup after loading the view.
    }
    
}
