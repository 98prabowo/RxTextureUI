import RxCocoa
import RxSwift
import TextureSwiftSupport

extension ASTableNode: HasDelegate {
    public typealias Delegate = ASTableDelegate
}

internal class RxASTableDelegateProxy:
    DelegateProxy<ASTableNode, ASTableDelegate>,
    DelegateProxyType,
    ASTableDelegate {
    public private(set) weak var tableNode: ASTableNode?

    internal init(tableNode: ASTableNode) {
        self.tableNode = tableNode
        super.init(parentObject: tableNode,
                   delegateProxy: RxASTableDelegateProxy.self)
    }

    internal static func registerKnownImplementations() {
        register { RxASTableDelegateProxy(tableNode: $0) }
    }
}

extension Reactive where Base: ASTableNode {
    internal var delegate: DelegateProxy<ASTableNode, ASTableDelegate> {
        return RxASTableDelegateProxy.proxy(for: base)
    }
    
    public var reachBottom: ControlEvent<Void> {
        let layoutFinishSelector: Selector = #selector(ASTableNode.layoutDidFinish)
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
        
        let draggingSelector: Selector = #selector(ASTableDelegate.scrollViewDidEndDragging(_:willDecelerate:))
        let draggingTrigger: Observable<Void> = base.rx
            .methodInvoked(draggingSelector)
            .filter { [base] _ -> Bool in
                base.view.isReachBottom()
            }
            .mapToVoid()
        
        let deceleratingSelector: Selector = #selector(ASTableDelegate.scrollViewDidEndDecelerating(_:))
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
