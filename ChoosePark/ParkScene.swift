//
//  ParkScene.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/24.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParkScene: NSObject {
    
    var id : String
    var parkName : String
    var name : String
    var openTime : String
    var imageUrl : URL?
    var introduction : String
    
    init(_ id : String, parkName : String, name : String, openTime: String, imageUrlString: String, introduction : String) {
        self.id = id
        self.parkName = parkName
        self.name = name
        self.openTime = openTime
        self.imageUrl = URL(string: imageUrlString)
        self.introduction = introduction
    }
    
}

class ParkScenes: NSObject {
    
    private static var parkScenes : ParkScenes?
    static func sharedInstance() -> ParkScenes {
        if parkScenes == nil {
            parkScenes = ParkScenes()
        }
        
        return parkScenes!
    }
    
    var parkSceneArray : Array<ParkScene> = []
    
    func convertJsonToParkScenesWithData(_ data: Data?) {
        do {
            if let data = data {
                let json = try JSON(data: data)
                for dic in json["result"]["results"].arrayValue {
                    let parkScene : ParkScene = ParkScene.init(dic["_id"].string!,
                                                               parkName: dic["ParkName"].string!,
                                                               name: dic["Name"].string!,
                                                               openTime: dic["OpenTime"].string!,
                                                               imageUrlString: dic["Image"].string!,
                                                               introduction: dic["Introduction"].string!)
                    self.parkSceneArray.append(parkScene)
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
            }
        }
        catch {
            //TODO: error handling
        }
    }
    
    
}
