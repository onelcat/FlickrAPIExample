//
//  HSLog.swift
//  FlickrAPIExample
//
//  Created by haoshuai on 2020/3/3.
//  Copyright © 2020 haoshuai. All rights reserved.
//

import Foundation

func debuglog(_ items: Any..., function: String = #function, filePath: String = #file, lineNumber: Int = #line) {
    let fileName = filePath as NSString
    debugPrint(fileName.lastPathComponent,function , items)
}
