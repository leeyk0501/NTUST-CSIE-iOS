//
//  ViewController.swift
//  Hw01
//
//  Created by B10615013 on 2020/3/12.
//  Copyright © 2020 B10615013. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let fruit = ["🍎", "🍐", "🍊", "🍋", "🍉", "🍇"]
    var score = 0
    var col1 = [String]()
    var col2 = [String]()
    var col3 = [String]()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var helloTitle: UILabel!
    @IBOutlet weak var bingoScore: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        if component == 0 {
            pickerLabel.text = col1[row]
        } else if component == 1 {
            pickerLabel.text = col2[row]
        } else if component == 2 {
            pickerLabel.text = col3[row]
        }
        
        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 80)
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return col1.count
        } else if component == 1 {
            return col2.count
        } else {
            return col3.count
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return col1[row]
        } else if component == 1 {
            return col2[row]
        } else {
            return col3[row]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in 1...100 {
            col1.append(fruit[(Int)(arc4random()) % 6])
            col2.append(fruit[(Int)(arc4random()) % 6])
            col3.append(fruit[(Int)(arc4random()) % 6])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        func pleaseLogin() {
            let loginAlert = UIAlertController(title: "您還未輸入名字!", message: "請輸入名字", preferredStyle: .alert)
            self.present(loginAlert, animated: true, completion: nil)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                login()
            }
            loginAlert.addAction(okAction)
        }
        func login() {
            let alert = UIAlertController(title: "登入", message: "請輸入帳號密碼", preferredStyle: .alert)
            alert.addTextField {(textField) in
                textField.placeholder = "Login"
            }
            alert.addTextField {(textField) in
                textField.placeholder = "Password"
                textField.isSecureTextEntry = true
            }
            
            let okAction = UIAlertAction(title: "登入", style: .default) { (action) in
                let firstTextField = alert.textFields![0] as UITextField
                if firstTextField.text! != "" {
                    self.helloTitle.text = "您好, " + firstTextField.text!
                } else {
                    pleaseLogin()
                }
            }
            alert.addAction(okAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
        login()
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        let col1Num = Int(arc4random()) % 94 + 3
        let col2Num = Int(arc4random()) % 94 + 3
        let col3Num = Int(arc4random()) % 94 + 3
        pickerView.selectRow(col1Num, inComponent: 0, animated: true)
        pickerView.selectRow(col2Num, inComponent: 1, animated: true)
        pickerView.selectRow(col3Num, inComponent: 2, animated: true)
        
        //Bingo
        if(col1[col1Num] == col2[col2Num] && col2[col2Num] == col3[col3Num]) {
            score += 10
            self.bingoScore.text = "分數: " + String(score)
        }
    }
    
}
