//
//  DetailViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/25.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

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
            if let image = parkScene.image {
                self.parkSceneImageView.image = image
                self.setupImageViewClickAction()
            }
            else {
                if let imageUrl = parkScene.imageUrl {
                    parkScene.dataTask = ImageManager.init(configuration: nil).downloadImageFromUrl(url: imageUrl, errorHandler: { (error) in
                        //TODO: error handle
                        print(error.localizedDescription)
                        
                    }, completionHandler: { (image) in
                        if let image = image {
                            parkScene.image = image
                            self.setupImageViewClickAction()
                            DispatchQueue.main.async {
                                self.parkSceneImageView.image = image
                            }
                        }
                        else {
                            //TODO: 使用預設圖片
                        }
                    })
                    parkScene.dataTask!.resume()
                }
                else {
                    //TODO: 使用預設圖片
                }
            }
            
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
    
    func setupImageViewClickAction() {
        self.parkSceneImageView.isUserInteractionEnabled = true
        let tapGestureRecognition = UITapGestureRecognizer.init(target: self, action: #selector(onClickImageView(_:)))
        tapGestureRecognition.numberOfTapsRequired = 1
        tapGestureRecognition.delegate = self as? UIGestureRecognizerDelegate
        self.parkSceneImageView.addGestureRecognizer(tapGestureRecognition)
    }
    
    @objc func onClickImageView(_ sender: UITapGestureRecognizer) {
        let imageVC : ImageViewController = UIStoryboard.init(name: mainStoryboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: ImageViewControllerId) as! ImageViewController
        imageVC.parkSceneImage = self.parkSceneImageView.image
        self.navigationController?.pushViewController(imageVC, animated: true)
        
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
        let cell : OtherScenesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: detailViewOtherScenesCollectionCellId, for: indexPath) as! OtherScenesCollectionViewCell
        let parkSceneName : String = ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].name
        let parkSceneImageUrl : URL? = ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].imageUrl
        let parkSceneImage : UIImage? = ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].image
        
        cell.parkSceneNameLabel.text = parkSceneName
        
        if let parkSceneImage = parkSceneImage {
            cell.parkSceneImageView.image = parkSceneImage
        }
        else {
            if let parkSceneImageUrl = parkSceneImageUrl {
                ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].dataTask = ImageManager.init(configuration: nil).downloadImageFromUrl(url: parkSceneImageUrl, errorHandler: { (error) in
                    //TODO: error handle
                    print(error.localizedDescription)
                    
                }, completionHandler: { (image) in
                    if let image = image {
                        ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].image = image
                        DispatchQueue.main.async {
                            cell.parkSceneImageView.image = image
                        }
                    }
                    else {
                        //TODO: 沒有圖片用預設圖片
                    }
                })
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let image : UIImage? = ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].image
        if image == nil {
            let dataTask : URLSessionDataTask? = ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].dataTask
            if let dataTask = dataTask {
                dataTask.cancel()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let image : UIImage? = ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].image
        if image == nil {
            let dataTask : URLSessionDataTask? = ParkScenes.sharedInstance().parkSceneDic[self.parkName!]![indexPath.row].dataTask
            if let dataTask = dataTask {
                dataTask.resume()
            }
        }
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
