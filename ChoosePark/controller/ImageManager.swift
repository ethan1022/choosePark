//
//  ImageManager.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/25.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class ImageManager: NSObject {
    
    var session : URLSession
    
    init(configuration: URLSessionConfiguration?) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: .default)
        }
    }
    
    func downloadImageFromUrl(url: URL, errorHandler:@escaping((Error)->()), completionHandler:@escaping(UIImage?)->()) -> URLSessionDataTask {
        
        let downloadTask = self.session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                errorHandler(error)
            }
            else {
                if response != nil {
                    if let imageData = data, let image = UIImage(data: imageData) {
                        completionHandler(image)
                    }
                    else {
                        completionHandler(nil)
                        print("檔案可能損毀")
                    }
                }
                else {
                    completionHandler(nil)
                    print("資料庫沒有檔案")
                }
            }
        }
        
        return downloadTask
    }
}
