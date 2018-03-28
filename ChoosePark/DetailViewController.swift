//
//  DetailViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/25.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class DetailViewController: BasicViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var parkSceneImageView: UIImageView!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkSceneNameLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var introTextView: UITextView!
    @IBOutlet weak var otherScenesView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var introTextViewBottomConstraint: NSLayoutConstraint!
    
    var parkName : String!
    var indexPath : Int!
    var otherSceneArray : Array<ParkScene> = []
    let tempImage : UIImage = UIImage.init(named: tempImageName)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let parkSceneArray = ParkScenes.sharedInstance().parkSceneDic[self.parkName] {
            let parkScene : ParkScene = parkSceneArray[self.indexPath]
            self.parkNameLabel.text = parkScene.parkName
            self.parkSceneNameLabel.text = parkScene.name
            self.openTimeLabel.text = parkScene.openTime
            self.introTextView.text = parkScene.introduction
            
            self.errorLabel.isHidden = true
            
            if let image = parkScene.image {
                self.parkSceneImageView.image = image
                self.setupImageViewClickAction()
            }
            else {
                self.parkSceneImageView.image = self.tempImage
                if let imageUrl = parkScene.imageUrl {
                    parkScene.dataTask = ImageManager.init(configuration: nil).downloadImageFromUrl(url: imageUrl, errorHandler: { (error) in
                        DispatchQueue.main.async {
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = imageErrorMessage
                        }
                        print(error.localizedDescription)
                        
                    }, completionHandler: { (image) in
                        if let image = image {
                            parkScene.image = image
                            DispatchQueue.main.async {
                                self.setupImageViewClickAction()
                                self.parkSceneImageView.image = image
                            }
                        }
                        else {
                            self.parkSceneImageView.image = self.tempImage
                        }
                    })
                    parkScene.dataTask!.resume()
                }
                else {
                    self.parkSceneImageView.image = self.tempImage
                }
            }
            
            if self.otherSceneArray.count == 0 {
                self.otherScenesView.isHidden = true
                self.introTextViewBottomConstraint.constant = 0
            }
            else {
                self.otherScenesView.isHidden = false
            }
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
        return self.otherSceneArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : OtherScenesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: detailViewOtherScenesCollectionCellId, for: indexPath) as! OtherScenesCollectionViewCell
        let parkSceneName : String = self.otherSceneArray[indexPath.row].name
        let parkSceneImageUrl : URL? = self.otherSceneArray[indexPath.row].imageUrl
        let parkSceneImage : UIImage? = self.otherSceneArray[indexPath.row].image
        
        cell.parkSceneNameLabel.text = parkSceneName
        cell.parkSceneImageView.image = self.tempImage
        
        if let parkSceneImage = parkSceneImage {
            cell.parkSceneImageView.image = parkSceneImage
        }
        else {
            cell.parkSceneImageView.image = self.tempImage
            if let parkSceneImageUrl = parkSceneImageUrl {
                self.otherSceneArray[indexPath.row].dataTask = ImageManager.init(configuration: nil).downloadImageFromUrl(url: parkSceneImageUrl, errorHandler: { (error) in
                    print(error.localizedDescription)
                    
                }, completionHandler: { (image) in
                    if let image = image {
                        self.otherSceneArray[indexPath.row].image = image
                        DispatchQueue.main.async {
                            cell.parkSceneImageView.image = image
                        }
                    }
                    else {
                        cell.parkSceneImageView.image = self.tempImage
                    }
                })
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let image : UIImage? = self.otherSceneArray[indexPath.row].image
        if image == nil {
            let dataTask : URLSessionDataTask? = self.otherSceneArray[indexPath.row].dataTask
            if let dataTask = dataTask {
                dataTask.cancel()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let image : UIImage? = self.otherSceneArray[indexPath.row].image
        if image == nil {
            let dataTask : URLSessionDataTask? = self.otherSceneArray[indexPath.row].dataTask
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
