//
//  ASEditableTextNode+Rx.swift
//  
//
//  Created by Dimas Prabowo on 05/06/23.

import AsyncDisplayKit
import RxCocoa
import RxSwift

extension Reactive where Base: ASEditableTextNode {
    public var delegate: DelegateProxy<ASEditableTextNode, ASEditableTextNodeDelegate> {
        return RxASEditableTextNodeDelegateProxy.proxy(for: base)
    }
    
    /// Reactive wrapper for `text` property.
    public var attributedText: ControlProperty<NSAttributedString?> {
        let source: Observable<NSAttributedString?> = .deferred { [weak editableTextNode = self.base] in
            let attributedText = editableTextNode?.attributedText
            
            let textChanged: Observable<NSAttributedString?> = editableTextNode?.rx.delegate
                .methodInvoked(#selector(ASEditableTextNodeDelegate.editableTextNodeDidUpdateText(_:)))
                .observe(on: MainScheduler.asyncInstance)
                .map { _ in
                    return editableTextNode?.attributedText
                } ?? .empty()
            
            return textChanged.startWith(attributedText)
        }
        
        let bindingObserver = ASBinder(self.base) { node, attributedText in
            node.attributedText = attributedText
        }
        
        return ControlProperty(values: source, valueSink: bindingObserver)
    }
    
    /// Binder for text with string.
    /// - Parameters:
    ///     - attributes: List of attributes for the text.
    public func text(_ attributes: [NSAttributedString.Key: Any]?) -> ASBinder<String?> {
        return ASBinder(self.base) { node, text in
            guard let text = text else {
                node.attributedText = nil
                return
            }
            
            node.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
    }
}
