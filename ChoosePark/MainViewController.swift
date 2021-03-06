//
//  MainViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/23.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: BasicViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var reloadDataButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    let tempImage : UIImage = UIImage.init(named: tempImageName)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.emptyView.isHidden = true
        self.reloadDataButton.layer.cornerRadius = 20
        self.reloadDataButton.clipsToBounds = true
        
        ApiManager.init().fetchNewDataWithLimitNumber(nil, offset: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(_:)), name: NSNotification.Name(rawValue: reloadTableViewNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataErrorHandle(_:)), name: NSNotification.Name(rawValue: jsonErrorNotification), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: reloadTableViewNotification), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: jsonErrorNotification), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func reloadTableView(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    @objc func dataErrorHandle(_ notification: Notification) {
        self.emptyView.isHidden = false
    }
    
    @IBAction func onClickReloadDataButton(_ sender: Any) {
        self.emptyView.isHidden = true
        ApiManager.init().fetchNewDataWithLimitNumber(nil, offset: nil)
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
        let cell : ParkSceneTableViewCell = tableView.dequeueReusableCell(withIdentifier: mainViewTableViewCellId, for: indexPath) as! ParkSceneTableViewCell
        
        let parkName = ParkScenes.sharedInstance().parkNameArray[indexPath.section]
        let parkSceneName : String = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].name
        let singleParkName : String = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].parkName
        let parkSceneIntro : String = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].introduction
        let parkSceneImageUrl : URL? = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].imageUrl
        let parkSceneImage : UIImage? = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].image
        
        cell.parkNameLabel.text = singleParkName
        cell.parkSceneNameLabel.text = parkSceneName
        cell.parkSceneIntroLabel.text = parkSceneIntro
        
        if let parkSceneImage = parkSceneImage {
            cell.parkSceneImageView.image = parkSceneImage
        }
        else {
            cell.parkSceneImageView.image = self.tempImage
            if let parkSceneImageUrl = parkSceneImageUrl {
                ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].dataTask = ImageManager.init(configuration: nil).downloadImageFromUrl(url: parkSceneImageUrl, errorHandler: { (error) in
                    print(error.localizedDescription)
                    //Just show temp image
                    
                }, completionHandler: { (image) in
                    if let image = image {
                        ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].image = image
                        DispatchQueue.main.async {
                            cell.parkSceneImageView.image = image
                        }
                    }
                })
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let parkName = ParkScenes.sharedInstance().parkNameArray[indexPath.section]
        let detailVC : DetailViewController = UIStoryboard.init(name: mainStoryboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: DetailViewControllerId) as! DetailViewController
        var otherSceneArray = ParkScenes.sharedInstance().parkSceneDic[parkName]!
        otherSceneArray.remove(at: indexPath.row)
        detailVC.parkName = parkName
        detailVC.indexPath = indexPath.row
        detailVC.otherSceneArray = otherSceneArray
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let parkName = ParkScenes.sharedInstance().parkNameArray[indexPath.section]
        let image : UIImage? = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].image
        let dataTask : URLSessionDataTask? = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].dataTask
        if image == nil {
            if let dataTask = dataTask {
                dataTask.cancel()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let parkName = ParkScenes.sharedInstance().parkNameArray[indexPath.section]
        let image : UIImage? = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].image
        let dataTask : URLSessionDataTask? = ParkScenes.sharedInstance().parkSceneDic[parkName]![indexPath.row].dataTask
        if image == nil {
            if let dataTask = dataTask {
                dataTask.resume()
            }
        }
    }


}

