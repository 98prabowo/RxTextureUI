import RxCocoa
import RxSwift
import TextureSwiftSupport

// Reference: https://www.objc.io/issues/3-views/scroll-view/#:~:text=The%20content%20size%20of%20a,0%2C%20h%3A0%7D%20.
extension UIScrollView {
    internal var isReachTop: Bool {
        let isScrollUp: Bool = panGestureRecognizer.translation(in: superview).y > 0
        let contentOffsetY: CGFloat = contentOffset.y
        let contentSizeHeight: CGFloat = contentSize.height
        let visibleSizeHeight: CGFloat = frame.size.height
        
        // Content is smaller than visible frame (No scrolling on specific axis)
        if contentSizeHeight > 0.0, contentSizeHeight <= visibleSizeHeight {
            return true
        }
        
        return isScrollUp && contentOffsetY == 0.0
    }
    
    internal func isReachBottom(factor: CGFloat = 2) -> Bool {
        let isScrollDown: Bool = panGestureRecognizer.translation(in: superview).y < 0
        let contentOffsetY: CGFloat = contentOffset.y
        let contentSizeHeight: CGFloat = contentSize.height
        let visibleSizeHeight: CGFloat = frame.size.height
        let maxContentOffsetHeight: CGFloat = contentOffsetY + visibleSizeHeight
        
        // Content is smaller than visible frame (No scrolling on specific axis)
        if contentSizeHeight > 0.0, contentSizeHeight <= visibleSizeHeight {
            return true
        }
        
        // Return true when the contentOffset approach the point in the scrollView
        // where the point  in `factor` screen away from the end of the current content
        let numberOfScreenToBottom: CGFloat = factor
        let bottomOffset: CGFloat = visibleSizeHeight * numberOfScreenToBottom
        return isScrollDown && maxContentOffsetHeight >= contentSizeHeight - bottomOffset
    }
    
    internal var isReachFarLeft: Bool {
        let isScrollLeft: Bool = panGestureRecognizer.translation(in: superview).x > 0
        let contentOffsetX: CGFloat = contentOffset.x
        let contentSizeWidth: CGFloat = contentSize.width
        let visibleSizeWidth: CGFloat = frame.size.width
        
        // Content is smaller than visible frame (No scrolling on specific axis)
        if contentSizeWidth > 0.0, contentSizeWidth <= visibleSizeWidth {
            return true
        }
        
        return isScrollLeft && contentOffsetX == 0.0
    }
    
    internal func isReachFarRight(factor: CGFloat = 2) -> Bool {
        let isScrollRight: Bool = panGestureRecognizer.translation(in: superview).x < 0
        let contentOffsetX: CGFloat = contentOffset.x
        let contentSizeWidth: CGFloat = contentSize.width
        let visibleSizeWidth: CGFloat = frame.size.width
        let maxContentOffsetWidth: CGFloat = contentOffsetX + visibleSizeWidth
        
        // Content is smaller than visible frame (No scrolling on specific axis)
        if contentSizeWidth > 0.0, contentSizeWidth <= visibleSizeWidth {
            return true
        }
        
        // Return true when the contentOffset approach the point in the scrollView
        // where the point  in `factor` screen away from the end of the current content
        let numberOfScreenToFarRight: CGFloat = factor
        let rightOffset: CGFloat = visibleSizeWidth * numberOfScreenToFarRight
        return isScrollRight && maxContentOffsetWidth >= contentSizeWidth - rightOffset
    }
}

extension Reactive where Base: UIScrollView {
    /// Control event to notify client that `UIScrollView` is reaching top
    public var reachTop: ControlEvent<Void> {
        let contentSizeSelector: Selector = #selector(setter: UIScrollView.contentSize)
        let contentSizeTrigger: Observable<Void> = base.rx
            .delegate
            .methodInvoked(contentSizeSelector)
            .map { [base] _ -> CGFloat in
                base.contentSize.height
            }
            .distinctUntilChanged()
            .filter { [base] _ -> Bool in
                base.isReachTop
            }
            .mapToVoid()
        
        let draggingTrigger: Observable<Void> = base.rx
            .didEndDragging
            .asObservable()
            .filter { [base] _ -> Bool in
                base.isReachTop
            }
            .mapToVoid()
        
        let deceleratingTrigger: Observable<Void> = base .rx
            .didEndDecelerating
            .asObservable()
            .filter { [base] _ -> Bool in
                base.isReachTop
            }
            .mapToVoid()
        
        let merge: Observable<Void> = Observable.merge(
            contentSizeTrigger,
            draggingTrigger,
            deceleratingTrigger
        )
        
        return ControlEvent(events: merge)
    }
    
    /// Control event to notify client that `UIScrollView` is reaching bottom
    public var reachBottom: ControlEvent<Void> {
        let contentSizeSelector: Selector = #selector(setter: UIScrollView.contentSize)
        let contentSizeTrigger: Observable<Void> = base.rx
            .methodInvoked(contentSizeSelector)
            .map { [base] _ -> CGFloat in
                base.contentSize.height
            }
            .distinctUntilChanged()
            .filter { [base] _ -> Bool in
                base.isReachBottom()
            }
            .mapToVoid()
        
        let draggingTrigger: Observable<Void> = base.rx
            .didEndDragging
            .asObservable()
            .filter { [base] _ -> Bool in
                base.isReachBottom()
            }
            .mapToVoid()
        
        let deceleratingTrigger: Observable<Void> = base .rx
            .didEndDecelerating
            .asObservable()
            .filter { [base] _ -> Bool in
                base.isReachBottom()
            }
            .mapToVoid()
        
        let merge: Observable<Void> = Observable.merge(
            contentSizeTrigger,
            draggingTrigger,
            deceleratingTrigger
        )
        
        return ControlEvent(events: merge)
    }
    
    /// Control event to notify client that `UIScrollView` is reaching far left
    public var reachFarLeft: ControlEvent<Void> {
        let contentSizeSelector: Selector = #selector(setter: UIScrollView.contentSize)
        let contentSizeTrigger: Observable<Void> = base.rx
            .methodInvoked(contentSizeSelector)
            .map { [base] _ -> CGFloat in
                base.contentSize.width
            }
            .distinctUntilChanged()
            .filter { [base] _ -> Bool in
                base.isReachFarLeft
            }
            .mapToVoid()
        
        let draggingTrigger: Observable<Void> = base.rx
            .didEndDragging
            .asObservable()
            .filter { [base] _ -> Bool in
                base.isReachFarLeft
            }
            .mapToVoid()
        
        let deceleratingTrigger: Observable<Void> = base .rx
            .didEndDecelerating
            .asObservable()
            .filter { [base] _ -> Bool in
                base.isReachFarLeft
            }
            .mapToVoid()
        
        let merge: Observable<Void> = Observable.merge(
            contentSizeTrigger,
            draggingTrigger,
            deceleratingTrigger
        )
        
        return ControlEvent(events: merge)
    }
    
    /// Control event to notify client that `UIScrollView` is reaching far right
    public var reachFarRight: ControlEvent<Void> {
        let contentSizeSelector: Selector = #selector(setter: UIScrollView.contentSize)
        let contentSizeTrigger: Observable<Void> = base.rx
            .methodInvoked(contentSizeSelector)
            .map { [base] _ -> CGFloat in
                base.contentSize.width
            }
            .distinctUntilChanged()
            .filter { [base] _ -> Bool in
                base.isReachFarRight()
            }
            .mapToVoid()
        
        let draggingTrigger: Observable<Void> = base.rx
            .didEndDragging
            .asObservable()
            .filter { [base] _ -> Bool in
                base.isReachFarRight()
            }
            .mapToVoid()
        
        let deceleratingTrigger: Observable<Void> = base .rx
            .didEndDecelerating
            .asObservable()
            .filter { [base] _ -> Bool in
                base.isReachFarRight()
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
