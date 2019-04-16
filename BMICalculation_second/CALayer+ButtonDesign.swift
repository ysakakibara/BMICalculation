//
//  CALayer+ButtonDesign.swift
//  BMICalculation_second
//
//  Created by sakaki on 2019/04/08.
//  Copyright © 2019年 sakaki. All rights reserved.
//

import UIKit

extension CALayer {
    
    /// 角丸ボタンのデザインを適用する
    func applyRoundButtonDesign(borderColor: UIColor) {
        // 枠線
        self.borderWidth = 1.0
        self.borderColor = borderColor.cgColor
        // 影
        self.shadowColor = borderColor.cgColor
        self.shadowOffset = CGSize(width: 1, height: 1)
        self.shadowRadius = 0.0
        self.shadowOpacity = 1.0
    }
    
}
