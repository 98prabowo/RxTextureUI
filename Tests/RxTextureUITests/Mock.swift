//
//  Mock.swift
//  
//
//  Created by Dimas Prabowo on 14/06/23.
//

import UIKit

extension NSAttributedString {
    internal static let mockAttributedApple = NSAttributedString(string: "apple")
    internal static let mockAttributedOrange = NSAttributedString(string: "orange")
}

extension String {
    internal static let mockApple = "apple"
    internal static let mockOrange = "orange"
}

extension UIImage {
    internal convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    internal static let mockRed = UIImage(color: .systemRed)!
    internal static let mockBlue = UIImage(color: .systemBlue)!
}
