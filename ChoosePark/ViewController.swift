//
//  ViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/23.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ApiManager.init().fetchNewDataWithLimitNumber(10, offset: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
    }
    
    @objc func reloadData() {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ParkScenes.sharedInstance().parkSceneArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ParkSceneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "parkSceneCell", for: indexPath) as! ParkSceneTableViewCell
        let parkSceneName : String = ParkScenes.sharedInstance().parkSceneArray[indexPath.row].name
        let parkName : String = ParkScenes.sharedInstance().parkSceneArray[indexPath.row].parkName
        let parkSceneIntro : String = ParkScenes.sharedInstance().parkSceneArray[indexPath.row].introduction
        
        cell.parkNameLabel.text = parkName
        cell.parkSceneNameLabel.text = parkSceneName
        cell.parkSceneIntroLabel.text = parkSceneIntro
        
        return cell
    }


}

