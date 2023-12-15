//
//  ASImageNode+Rx.swift
//  
//
//  Created by Dimas Prabowo on 05/06/23.

import RxCocoa
import RxSwift
import TextureSwiftSupport

extension Reactive where Base: ASImageNode {
    /// Binder of `UIImage` for image property of `ASImageNode`.
    public var image: ASBinder<UIImage?> {
        return ASBinder(self.base) { node, image in
            node.image = image
        }
    }
}
