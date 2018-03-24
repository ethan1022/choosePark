//
//  DetailViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/25.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var parkSceneImageView: UIImageView!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkSceneNameLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    var parkName : String?
    var indexPath : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let parkName = self.parkName,
            let indexPath = self.indexPath,
            let parkSceneArray = ParkScenes.sharedInstance().parkSceneDic[parkName] {
            
            let parkScene : ParkScene = parkSceneArray[indexPath]
            self.parkNameLabel.text = parkScene.parkName
            self.parkSceneNameLabel.text = parkScene.name
            self.openTimeLabel.text = parkScene.openTime
            self.introLabel.text = parkScene.introduction
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
