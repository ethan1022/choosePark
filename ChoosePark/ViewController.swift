//
//  ViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/23.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ApiManager.init().fetchNewDataWithLimitNumber(nil, offset: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
    }
    
    @objc func reloadData() {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ParkScenes.sharedInstance().parkNameArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ParkScenes.sharedInstance().parkNameArray[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle : String = ParkScenes.sharedInstance().parkNameArray[section]
        return ParkScenes.sharedInstance().parkSceneDic[sectionTitle]!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ParkSceneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "parkSceneCell", for: indexPath) as! ParkSceneTableViewCell
        
        let parkName = ParkScenes.sharedInstance().parkNameArray[indexPath.section]
        let parkSceneName : String = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].name
        let singleParkName : String = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].parkName
        let parkSceneIntro : String = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].introduction
        let parkSceneImage : URL? = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].imageUrl
        
        cell.parkNameLabel.text = singleParkName
        cell.parkSceneNameLabel.text = parkSceneName
        cell.parkSceneIntroLabel.text = parkSceneIntro
        cell.parkSceneImageView.image = nil //TODO: 先用預設圖片
        
        if let parkSceneImage = parkSceneImage {
            ImageManager.init(nil).downloadImageFromUrl(url: parkSceneImage, errorHandler: { (error) in
                //TODO: error handle
                print(error.localizedDescription)
                
            }, completionHandler: { (image) in
                DispatchQueue.main.async {
                    if let image = image {
                        cell.parkSceneImageView.image = image
                    }
                    else {
                        //TODO: 沒有圖片用預設圖片
                    }
                }
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let parkName = ParkScenes.sharedInstance().parkNameArray[indexPath.section]
        let detailVC : DetailViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailVC.parkName = parkName
        detailVC.indexPath = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }


}

