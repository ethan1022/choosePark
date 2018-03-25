//
//  DetailViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/25.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var parkSceneImageView: UIImageView!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkSceneNameLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet weak var otherScenesView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
            self.introTextView.text = parkScene.introduction
            
            
            if parkSceneArray.count == 1 {
                self.otherScenesView.isHidden = true
            }
            else {
                self.otherScenesView.isHidden = false
            }
        }
        else {
            //TODO: error handling
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let parkName = self.parkName, let parkSceneArray = ParkScenes.sharedInstance().parkSceneDic[parkName] {
            return parkSceneArray.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : OtherScenesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherScenesCollectionCell", for: indexPath) as! OtherScenesCollectionViewCell
        let parkSceneName : String = ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].name
        cell.parkSceneNameLabel.text = parkSceneName
        
        return cell
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
