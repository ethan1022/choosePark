//
//  ApiManager.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/24.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager : NSObject {
    
    let requestUrl = URL(string:apiRequestUrlString)
    
    func fetchNewDataWithLimitNumber(_ limit:Int? , offset:Int?) {
        var paramDic : Dictionary = [apiRequestParamScopeKey:apiRequestParamScopeValue,
                                     apiRequestParamRidKey:apiRequestParamRidValue]
        
        if let limit = limit {
            paramDic[apiRequestParamLimitKey] = "\(limit)"
        }
        if let offset = offset {
            paramDic[apiRequestParamOffsetKey] = "\(offset)"
        }
        
        Alamofire.request(requestUrl!, method: .get, parameters: paramDic, encoding: URLEncoding.default, headers: nil).responseJSON { (dataResponse) in
            ParkScenes.sharedInstance().convertJsonToParkScenesWithData(dataResponse.data)
        }
    }
    
}
