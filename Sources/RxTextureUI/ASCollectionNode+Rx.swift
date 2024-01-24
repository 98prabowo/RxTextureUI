import RxCocoa
import RxSwift
import TextureSwiftSupport

extension ASCollectionNode: HasDelegate {
    public typealias Delegate = ASCollectionDelegate
    
    public func isReach(threshold: Int) -> Bool {
        let isScrollDown: Bool = view.panGestureRecognizer.translation(in: view.superview).y < 0
        let visibleSections: [Int] = indexPathsForVisibleItems.map(\.section)
        guard let numberOfSections: Int = dataSource?.numberOfSections?(in: self) else { return false }
        let thresholdSection: Int = max((numberOfSections - 1) - threshold, 0)
        return isScrollDown && visibleSections.contains { $0 == thresholdSection }
    }
    
    public func isItemPresent(index: Int) -> Bool {
        let isScrollDown: Bool = view.panGestureRecognizer.translation(in: view.superview).y < 0
        let visibleSections: [Int] = indexPathsForVisibleItems.map(\.section)
        return isScrollDown && visibleSections.contains { $0 == index }
    }
}

internal class RxASCollectionDelegateProxy:
    DelegateProxy<ASCollectionNode, ASCollectionDelegate>,
    DelegateProxyType,
    ASCollectionDelegate {
    public private(set) weak var collectionNode: ASCollectionNode?

    internal init(collectionNode: ASCollectionNode) {
        self.collectionNode = collectionNode
        super.init(parentObject: collectionNode,
                   delegateProxy: RxASCollectionDelegateProxy.self)
    }

    internal static func registerKnownImplementations() {
        register { RxASCollectionDelegateProxy(collectionNode: $0) }
    }
}

extension Reactive where Base: ASCollectionNode {
    internal var delegate: DelegateProxy<ASCollectionNode, ASCollectionDelegate> {
        return RxASCollectionDelegateProxy.proxy(for: base)
    }
    
    /// Trigger for collection node reach bottom edge
    public var reachBottom: ControlEvent<Void> {
        let layoutFinishSelector: Selector = #selector(ASCollectionNode.layoutDidFinish)
        let contentSizeTrigger: Observable<Void> = base.rx
            .delegate
            .methodInvoked(layoutFinishSelector)
            .map { [base] _ -> CGFloat in
                base.view.contentSize.height
            }
            .distinctUntilChanged()
            .filter { [base] _ -> Bool in
                base.view.isReachBottom()
            }
            .mapToVoid()
        
        let draggingSelector: Selector = #selector(ASCollectionDelegate.scrollViewDidEndDragging(_:willDecelerate:))
        let draggingTrigger: Observable<Void> = base.rx
            .delegate
            .methodInvoked(draggingSelector)
            .filter { [base] _ -> Bool in
                base.view.isReachBottom()
            }
            .mapToVoid()
        
        let deceleratingSelector: Selector = #selector(ASCollectionDelegate.scrollViewDidEndDecelerating(_:))
        let deceleratingTrigger: Observable<Void> = base.rx
            .delegate
            .methodInvoked(deceleratingSelector)
            .filter { [base] _ -> Bool in
                base.view.isReachBottom()
            }
            .mapToVoid()
        
        let merge: Observable<Void> = Observable.merge(
            contentSizeTrigger,
            draggingTrigger,
            deceleratingTrigger
        )
        
        return ControlEvent(events: merge)
    }
    
    /// Trigger for collection node reach item n from bottom.
    ///
    /// - Parameters:
    ///    - item: Threshold index for trigger.
    public func fromBottom(item index: Int) -> ControlEvent<Void> {
        let willDisplaySelector: Selector = #selector(ASCollectionDelegate.collectionNode(_:willDisplayItemWith:))
        let thresholdTrigger: Observable<Void> = base.rx
            .delegate
            .methodInvoked(willDisplaySelector)
            .map { [base] _ -> Bool in
                base.isReach(threshold: index)
            }
            .filter { $0 }
            .mapToVoid()
        
        return ControlEvent(events: thresholdTrigger)
    }
    
    /// Trigger for collection node if item n will present.
    ///
    /// - Parameters:
    ///    - index: Item index.
    public func itemPresent(index: Int) -> ControlEvent<Bool> {
        let willDisplaySelector: Selector = #selector(ASCollectionDelegate.collectionNode(_:willDisplayItemWith:))
        let firstItemPresentTrigger: Observable<Bool> = base.rx
            .delegate
            .methodInvoked(willDisplaySelector)
            .map { [base] _ -> Bool in
                base.isItemPresent(index: index)
            }
        
        return ControlEvent(events: firstItemPresentTrigger)
    }
}
