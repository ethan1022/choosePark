//
//  ApiManager.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/24.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager : NSObject {
    
    let requestUrl = URL(string:"http://data.taipei/opendata/datalist/apiAccess")
    
    func fetchNewDataWithLimitNumber(_ limit:Int? , offset:Int?) {
        var paramDic : Dictionary = ["scope":"resourceAquire", "rid":"bf073841-c734-49bf-a97f-3757a6013812"]
        
        if let limit = limit {
            paramDic["limit"] = "\(limit)"
        }
        if let offset = offset {
            paramDic["offset"] = "\(offset)"
        }
        
        Alamofire.request(requestUrl!, method: .get, parameters: paramDic, encoding: URLEncoding.default, headers: nil).responseJSON { (dataResponse) in
            ParkScenes.sharedInstance().convertJsonToParkScenesWithData(dataResponse.data)
        }
    }
    
}
