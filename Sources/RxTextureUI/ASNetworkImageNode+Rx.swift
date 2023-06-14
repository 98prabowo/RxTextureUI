//
//  ASNetworkImageNode+Rx.swift
//  Core
//
//  Created by Dimas Prabowo on 05/06/23.

import AsyncDisplayKit
import RxSwift
import RxCocoa

extension Reactive where Base: ASNetworkImageNode {
    public var url: ASBinder<URL?> {
        return ASBinder(self.base) { node, url in
            node.setURL(url, resetToDefault: true)
        }
    }
    
    public func url(resetToDefault: Bool) -> ASBinder<URL?> {
        return ASBinder(self.base) { node, url in
            node.setURL(url, resetToDefault: resetToDefault)
        }
    }
}
