//
//  BasicViewController.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/28.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func singleButtonAlertController(title: String, message: String, buttonTitle: String, buttonAction:((UIAlertAction) -> Void)?) {
        let alertView : UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let alertAction : UIAlertAction = UIAlertAction.init(title: buttonTitle, style: .default, handler: buttonAction)
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func doubleButtonAlertController(title: String, message: String, cancelButtonTitle: String, confirmButtonTitle: String, cancelButtonAction:((UIAlertAction) -> Void)?, confirmButtonAction:((UIAlertAction) -> Void)?) {
        let alertView : UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let cancelAlertAction : UIAlertAction = UIAlertAction.init(title: cancelButtonTitle, style: .cancel, handler: cancelButtonAction)
        let confirmAlertAction : UIAlertAction = UIAlertAction.init(title: confirmButtonTitle, style: .default, handler: confirmButtonAction)
        alertView.addAction(cancelAlertAction)
        alertView.addAction(confirmAlertAction)
        self.present(alertView, animated: true, completion: nil)
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
