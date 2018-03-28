//
//  Strings.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/25.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import Foundation

//MARK: - Notification Name
let reloadTableViewNotification = "reloadTableView"

//MARK: - Cell Identifier
let mainViewTableViewCellId = "parkSceneCell"
let detailViewOtherScenesCollectionCellId = "otherScenesCollectionCell"

//MARK: - Storyboard Name
let mainStoryboardName = "Main"

//MARK: - ViewController Identifier
let DetailViewControllerId = "detailVC"
let ImageViewControllerId = "imageVC"

//MARK: - Image Name
let tempImageName = "tempImage"

//MARK: - Api
let apiRequestUrlString = "http://data.taipei/opendata/datalist/apiAccess"
let apiRequestParamScopeKey = "scope"
let apiRequestParamRidKey = "rid"
let apiRequestParamLimitKey = "limit"
let apiRequestParamOffsetKey = "offset"
let apiRequestParamScopeValue = "resourceAquire"
let apiRequestParamRidValue = "bf073841-c734-49bf-a97f-3757a6013812"

//MARK: - Response Json Key
let responseJsonKeyResult = "result"
let responseJsonKeyResults = "results"
let responseJsonKeyId = "_id"
let responseJsonKeyParkName = "ParkName"
let responseJsonKeyName = "Name"
let responseJsonKeyOpenTime = "OpenTime"
let responseJsonKeyImageUrl = "Image"
let responseJsonKeyIntroduction = "Introduction"



class Strings: NSObject {}
