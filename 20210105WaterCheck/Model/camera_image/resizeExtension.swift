//
//  resizeExtension.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/06.
//

import Foundation
import UIKit

extension UIImage
{
    func resize(width_size:CGFloat, height_size:CGFloat) -> UIImage?
    {
        let x_rate = width_size / self.size.width
        let y_rate = height_size / self.size.height
        let rect = CGRect(x: 0, y: 0, width: self.size.width * x_rate, height: self.size.height * y_rate)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return (image)
    }
}
