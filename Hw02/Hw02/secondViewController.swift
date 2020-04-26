//
//  secondViewController.swift
//  Hw02
//
//  Created by B10615013 on 2020/3/30.
//  Copyright © 2020 B10615013. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    var receiveStr: String? = nil
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let str = receiveStr {
            nameLabel.text = str
            image.image = UIImage(named: str)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
