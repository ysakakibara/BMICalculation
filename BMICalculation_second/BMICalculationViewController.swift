//
//  BMICalculationViewController.swift
//  BMICalculation_second
//
//  Created by sakaki on 2019/04/08.
//  Copyright © 2019年 sakaki. All rights reserved.
//

import UIKit

class BMICalculationViewController: UIViewController {
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var calculationButton: UIButton! {
        didSet {
            self.calculationButton.layer.applyRoundButtonDesign(borderColor: .gray)
            self.calculationButton.layer.cornerRadius = self.calculationButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var insertButton: UIButton! {
        didSet {
            self.insertButton.layer.applyRoundButtonDesign(borderColor: .gray)
            self.insertButton.layer.cornerRadius = self.insertButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var historyButton: UIButton! {
        didSet {
            self.historyButton.layer.applyRoundButtonDesign(borderColor: .gray)
            self.historyButton.layer.cornerRadius = self.historyButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var bmiListDeleteButton: UIButton! {
        didSet {
            self.bmiListDeleteButton.layer.applyRoundButtonDesign(borderColor: .gray)
            self.bmiListDeleteButton.layer.cornerRadius = self.bmiListDeleteButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var insertLabel: UILabel!
    
    // BMI登録リスト
    var bmiList : Array<String> = []
    
    // BMI保存用
    var strBmi :String = ""
    
    // BMI登録用
    var bmiInsert :String = ""
    
    // 身長
    var strHeight :String = ""
    
    // 体重
    var strWeight :String = ""
    
    // UserDefaultsを参照している
    let userDefaults = UserDefaults.standard
    
    // ツールバー
    private var toolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightTextField.delegate = self
        self.weightTextField.delegate = self
        
        // doneボタン設置
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtn(_:)))
        toolBar.items = [toolBarButton]
        heightTextField.inputAccessoryView = toolBar
        weightTextField.inputAccessoryView = toolBar
        
        heightTextField.keyboardType = UIKeyboardType.decimalPad
        weightTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // doneボタン
    @objc private func doneBtn(_ sender: UIBarButtonItem) {
        self.heightTextField.resignFirstResponder()
        self.weightTextField.resignFirstResponder()
    }
    
    @IBAction func tapCalculationButton(_ sender: Any) {

        self.heightTextField.resignFirstResponder()
        self.weightTextField.resignFirstResponder()
        
        // 入力された身長を読み込む
        strHeight = self.heightTextField.text!
        // 入力された体重を読み込む
        strWeight = self.weightTextField.text!
        
        if strHeight == "" || strWeight == "" {
            self.showErrorDialog(title: "エラー", message: "数字を入力してください。")
            return
        }
        
        if Float(strHeight) == nil || Float(strWeight) == nil {
            self.showErrorDialog(title: "エラー", message: "不正な値です。")
            return
        }
        
        // 身長を２乗し、単位をmに、型をFloatに変換
        let floHeight: Float = Float(strHeight)! * Float(strHeight)! / 10000
        // Float型に変換
        let floWeight: Float = Float(strWeight)!
        
        if floHeight == 0 || floWeight == 0 {
            self.showErrorDialog(title: "エラー", message: "0以外を入力してください。")
            return
        }
        
        // 少数第二位を四捨五入
        let result = round ((floWeight / floHeight) * 10)
        
        // BMIラベルに表示
        bmiLabel.text = String(result / 10)
        
        // BMIをString型に変換
        strBmi = String(result / 10)
    }
    
    @IBAction func tapInsertButton(_ sender: Any) {
        
        if strHeight == "" || strWeight == "" || Float(strHeight) == nil || Float(strWeight) == nil {
            self.showErrorDialog(title: "エラー", message: "不正な値なので登録できません。")
            return
        }
        // 身長を２乗し、単位をmに、型をFloatに変換
        let floHeight: Float = Float(strHeight)! * Float(strHeight)! / 10000
        // Float型に変換
        let floWeight: Float = Float(strWeight)!
        
        if floHeight == 0 || floWeight == 0 {
            self.showErrorDialog(title: "エラー", message: "0以外を入力してください。")
            return
        }
        // 現在日付を取得
        let now = NSDate()
        
        // DateをStringに変換し、MM月dd日表記に変更
        let date = DateUtils.stringFromDate(date: now as Date, format: "M月d日")
        
        // 日付、身長、体重、BMIを一つの変数にまとめる
        bmiInsert = date + "," + strHeight + "cm," + strWeight + "kg," + strBmi
        
        // 配列に格納
        bmiList.append(bmiInsert)
        
        // UserDefaultsにBMIデータを保存
        userDefaults.set(bmiList, forKey: "bmiList")
        
        // 登録ボタン押下時、表示
        insertLabel.text = "BMIを登録しました。"
    }
    
    @IBAction func tapBmiListDelete(_ sender: Any) {
        userDefaults.removeObject(forKey: "bmiList")
    }
    
    class DateUtils {
        // DateをStringに変換する
        class func stringFromDate(date: Date, format: String) -> String {
            let formatter: DateFormatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = format
            return formatter.string(from: date)
        }
    }
    
    func showErrorDialog(title: String?, message: String?) {
        let errorAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) ->
            Void in
        })
        
        errorAlert.addAction(defaultAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
}

// MARK: - UITextFieldDelegate

extension BMICalculationViewController: UITextFieldDelegate {
    
    // テキストフィールド編集時の処理
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let str = textField.text else { return true }
        
        // 文字数がtextField.tag以下ならtrueを返す.
        return str.count + string.count - range.length <= textField.tag
    }
    
    // returnボタン押下時の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
