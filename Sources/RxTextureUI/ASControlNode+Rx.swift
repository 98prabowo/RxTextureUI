//
//  ASControlNode+Rx.swift
//  Core
//
//  Created by Dimas Prabowo on 05/06/23.

import AsyncDisplayKit
import RxCocoa
import RxSwift

extension Reactive where Base: ASControlNode {
    public func event(_ type: ASControlNodeEvent) -> ControlEvent<Base> {
        let source: Observable<Base> = Observable
            .create { [weak control = self.base] observer in
                MainScheduler.ensureExecutingOnScheduler()
                
                guard let control = control else {
                    observer.on(.completed)
                    return Disposables.create()
                }
                
                let observer = ASControlTarget(control, type) { node in
                    observer.on(.next(node))
                }
                
                return observer
            }
            .take(until: deallocated)
        return ControlEvent(events: source)
    }
    
    public var tap: Observable<Void> {
        return self.event(.touchUpInside).mapToVoid()
    }
    
    public func tap(to relay: PublishRelay<()>) -> Disposable {
        return self.event(.touchUpInside)
            .mapToVoid()
            .asSignalrOnErrorJustComplete()
            .emit(to: relay)
    }
    
    public var isHidden: ASBinder<Bool> {
        return ASBinder(self.base) { node, isHidden in
            node.isHidden = isHidden
        }
    }
    
    public var isEnabled: ASBinder<Bool> {
        return ASBinder(self.base) { node, isEnabled in
            node.isEnabled = isEnabled
        }
    }
    
    public var isHighlighted: ASBinder<Bool> {
        return ASBinder(self.base) { node, isHighlighted in
            node.isHighlighted = isHighlighted
        }
    }
    
    public var isSelected: ASBinder<Bool> {
        return ASBinder(self.base) { node, isSelected in
            node.isSelected = isSelected
        }
    }
}
