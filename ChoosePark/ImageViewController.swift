//
//  ImageViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/28.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class ImageViewController: BasicViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var parkSceneImageView: UIImageView!
    var parkSceneImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parkSceneImageView.image = self.parkSceneImage
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
        let doubleTapGesture : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delegate = self as? UIGestureRecognizerDelegate
        self.scrollView.addGestureRecognizer(doubleTapGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if self.scrollView.zoomScale < self.scrollView.maximumZoomScale {
            self.scrollView.setZoomScale(self.scrollView.maximumZoomScale, animated: true)
        }
        else {
            self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.parkSceneImageView
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
