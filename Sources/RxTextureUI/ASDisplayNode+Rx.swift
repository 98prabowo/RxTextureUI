//
//  ASDisplayNode+Rx.swift
//  Core
//
//  Created by Dimas Prabowo on 05/06/23.

import AsyncDisplayKit
import RxCocoa
import RxSwift

extension Reactive where Base: ASDisplayNode {
    public var didLoad: Observable<Void> {
        return methodInvoked(#selector(Base.didLoad))
            .map { _ in return }
            .asObservable()
    }
    
    public var didEnterPreloadState: Observable<Void> {
        return self.methodInvoked(#selector(Base.didEnterPreloadState))
            .map { _ in return }
            .asObservable()
    }
    
    public var didEnterDisplayState: Observable<Void> {
        return self.methodInvoked(#selector(Base.didEnterDisplayState))
            .map { _ in return }
            .asObservable()
    }
    
    public var didEnterVisibleState: Observable<Void> {
        return self.methodInvoked(#selector(Base.didEnterVisibleState))
            .map { _ in return }
            .asObservable()
    }
    
    public var didExitVisibleState: Observable<Void> {
        return self.methodInvoked(#selector(Base.didExitVisibleState))
            .map { _ in return }
            .asObservable()
    }
    
    public var didExitDisplayState: Observable<Void> {
        return self.methodInvoked(#selector(Base.didExitDisplayState))
            .map { _ in return }
            .asObservable()
    }
    
    public var didExitPreloadState: Observable<Void> {
        return self.methodInvoked(#selector(Base.didEnterPreloadState))
            .map { _ in return }
            .asObservable()
    }
}

extension Reactive where Base: ASDisplayNode {
    public var hide: ASBinder<Bool> {
        return ASBinder(self.base) { node, isHidden in
            node.isHidden = isHidden
        }
    }
    
    public var setNeedsLayout: Binder<Void> {
        return Binder(self.base) { node, _ in
            node.rxSetNeedsLayout()
        }
    }
}

extension ASDisplayNode {
    /// setNeedsLayout with avoid block layout measure passing before node loaded
    /// - important: block layout measure passing from rx.
    /// - returns: void
    public func rxSetNeedsLayout() {
        if self.isNodeLoaded {
            self.setNeedsLayout()
        } else {
            self.layoutIfNeeded()
            self.invalidateCalculatedLayout()
        }
    }
}
