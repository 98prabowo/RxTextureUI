import AsyncDisplayKit
import RxCocoa
import RxSwift

extension ASCollectionNode: HasDelegate {
    public typealias Delegate = ASCollectionDelegate
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
    
    public var reachBottom: ControlEvent<Void> {
        let layoutFinishSelector: Selector = #selector(ASCollectionNode.layoutDidFinish)
        let contentSizeTrigger: Observable<Void> = base.rx
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
            .methodInvoked(draggingSelector)
            .filter { [base] _ -> Bool in
                base.view.isReachBottom()
            }
            .mapToVoid()
        
        let deceleratingSelector: Selector = #selector(ASCollectionDelegate.scrollViewDidEndDecelerating(_:))
        let deceleratingTrigger: Observable<Void> = base.rx
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
}
