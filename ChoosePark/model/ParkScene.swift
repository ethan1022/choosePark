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
    var image : UIImage?
    
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
    
    var parkSceneDic : [String:Array<ParkScene>] = [:]
    var parkNameArray : Array<String> = []
    
    func convertJsonToParkScenesWithData(_ data: Data?) {
        do {
            if let data = data {
                let json = try JSON(data: data)
                for dic in json[responseJsonKeyResult][responseJsonKeyResults].arrayValue {
                    let parkScene : ParkScene = ParkScene.init(dic[responseJsonKeyId].string!,
                                                               parkName: dic[responseJsonKeyParkName].string!,
                                                               name: dic[responseJsonKeyName].string!,
                                                               openTime: dic[responseJsonKeyOpenTime].string!,
                                                               imageUrlString: dic[responseJsonKeyImageUrl].string!,
                                                               introduction: dic[responseJsonKeyIntroduction].string!)
                    
                    if self.parkNameArray.count == 0 || self.parkNameArray.last != dic[responseJsonKeyParkName].string {
                        self.parkNameArray.append(dic[responseJsonKeyParkName].string!)
                        self.parkSceneDic[dic[responseJsonKeyParkName].string!] = [parkScene]
                    }
                    else {
                        self.parkSceneDic[dic[responseJsonKeyParkName].string!]!.append(parkScene)
                    }
                    
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: reloadTableViewNotification), object: nil)
            }
        }
        catch {
            //TODO: error handling
        }
    }
    
    
}
