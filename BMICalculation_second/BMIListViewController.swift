//
//  BMIListViewController.swift
//  BMICalculation_second
//
//  Created by sakaki on 2019/04/08.
//  Copyright © 2019年 sakaki. All rights reserved.
//

import UIKit

class BMIListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let user = UserDefaults.standard
    
    // BMIデータ格納配列
    var bmiList : Array<String> = []
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            self.backButton.layer.applyRoundButtonDesign(borderColor: .gray)
            self.backButton.layer.cornerRadius = self.backButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var bmiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiTableView.dataSource = self
        
        // UserDefaultsからBMIデータを取り出す
        if let bmi = user.object(forKey: "bmiList") {
            bmiList = bmi as! Array<String>
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // BMIデータを分割
        let list = bmiList[indexPath.row].components(separatedBy: ",")
        
        // 各ラベルに振り分ける
        let dateLabel = cell.viewWithTag(1) as! UILabel
        let heightLabel = cell.viewWithTag(2) as! UILabel
        let weightLabel = cell.viewWithTag(3) as! UILabel
        let bmiLabel = cell.viewWithTag(4) as! UILabel
        
        // 日時
        dateLabel.text = list[0]
        
        // 身長
        heightLabel.text = list[1]
        
        // 体重
        weightLabel.text = list[2]
        
        // BMI
        bmiLabel.text = list[3]
        
        return cell
    }
    
}
