//
//  ViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/23.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

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
        
        cell.parkNameLabel.text = singleParkName
        cell.parkSceneNameLabel.text = parkSceneName
        cell.parkSceneIntroLabel.text = parkSceneIntro
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parkName = ParkScenes.sharedInstance().parkNameArray[indexPath.section]
        let detailVC : DetailViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailVC.parkName = parkName
        detailVC.indexPath = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
    }


}

