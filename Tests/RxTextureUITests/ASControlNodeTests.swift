//
//  ASControlNodeTests.swift
//  
//
//  Created by Dimas Prabowo on 14/06/23.

import AsyncDisplayKit
import RxCocoa
import RxSwift
import RxTest
import RxTextureUI
import XCTest

internal final class ASControlNodeTests: XCTestCase {
    // MARK: - Variables
    
    internal var sut: ASControlNode!
    internal var scheduler: TestScheduler!
    internal var disposeBag: DisposeBag!
    
    // MARK: - Setup
    
    override internal func setUp() {
        super.setUp()
        sut = ASControlNode()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override internal func tearDown() {
        super.tearDown()
        sut = nil
        scheduler = nil
        disposeBag = nil
    }
    
    internal func testEmitControlEvent() {
        scheduler.createHotObservable([
            .next(100, ASControlNodeEvent.touchUpInside),
            .next(200, ASControlNodeEvent.touchDown),
            .next(300, ASControlNodeEvent.touchUpOutside),
            .next(400, ASControlNodeEvent.touchDragInside),
            .next(500, ASControlNodeEvent.touchCancel)
        ])
        .subscribe(onNext: { [sut] event in
            sut!.sendActions(forControlEvents: event, with: nil)
        })
        .disposed(by: disposeBag)
        
        let outputEvent = scheduler
            .record(sut.rx.controlEvent(.touchUpInside)
                .map { _ -> ASControlNodeEvent in return .touchUpInside })
        let outputEvent2 = scheduler
            .record(sut.rx.controlEvent(.touchDown)
                .map { _ -> ASControlNodeEvent in return .touchDown })
        let outputEvent3 = scheduler
            .record(sut.rx.controlEvent(.touchUpOutside)
                .map { _ -> ASControlNodeEvent in return .touchUpOutside})
        let outputEvent4 = scheduler
            .record(sut.rx.controlEvent(.touchDragInside)
                .map { _ -> ASControlNodeEvent in return .touchDragInside })
        let outputEvent5 = scheduler
            .record(sut.rx.controlEvent(.touchCancel)
                .map { _ -> ASControlNodeEvent in return .touchCancel })
        
        scheduler.start()
        
        let expectEvent: [Recorded<Event<ASControlNodeEvent>>] = [
            .next(100, .touchUpInside)
        ]
        
        let expectEvent2: [Recorded<Event<ASControlNodeEvent>>] = [
            .next(200, .touchDown)
        ]
        
        let expectEvent3: [Recorded<Event<ASControlNodeEvent>>] = [
            .next(300, .touchUpOutside)
        ]
        
        let expectEvent4: [Recorded<Event<ASControlNodeEvent>>] = [
            .next(400, .touchDragInside)
        ]
        
        let expectEvent5: [Recorded<Event<ASControlNodeEvent>>] = [
            .next(500, .touchCancel)
        ]
        
        XCTAssertEqual(outputEvent.events, expectEvent)
        XCTAssertEqual(outputEvent2.events, expectEvent2)
        XCTAssertEqual(outputEvent3.events, expectEvent3)
        XCTAssertEqual(outputEvent4.events, expectEvent4)
        XCTAssertEqual(outputEvent5.events, expectEvent5)
    }
    
    internal func testEmitTap() {
        scheduler.createHotObservable([
            .next(100, ()),
            .next(200, ()),
            .next(300, ())
        ])
        .subscribe(onNext: { [sut] _ in
            sut!.sendActions(forControlEvents: .touchUpInside, with: nil)
        })
        .disposed(by: disposeBag)
        
        let outputEvent = scheduler
            .record(sut.rx.tap.map { _ in return true })
        
        scheduler.start()
        
        let expectEvent: [Recorded<Event<Bool>>] = [
            .next(100, true),
            .next(200, true),
            .next(300, true)
        ]
        
        XCTAssertEqual(outputEvent.events, expectEvent)
    }
    
    internal func testEmitTapRelay() {
        let emitter = PublishRelay<Void>()
        let accepter: Observable<Bool>
        
        accepter = emitter.map { _ in return true }.asObservable()
        
        let emitObserver = scheduler
            .createHotObservable([.next(100, ()),
                                  .next(200, ()),
                                  .next(300, ())])
        
        emitObserver.subscribe(onNext: { [sut] _ in
            sut!.sendActions(forControlEvents: .touchUpInside, with: nil)
        }).disposed(by: disposeBag)
        
        sut.rx.tap(to: emitter).disposed(by: disposeBag)
        
        let outputEvent = scheduler.record(accepter)
        
        scheduler.start()
        
        let expectEvent: [Recorded<Event<Bool>>] = [
            .next(100, true),
            .next(200, true),
            .next(300, true)
        ]
        
        XCTAssertEqual(outputEvent.events, expectEvent)
    }
    
    internal func testEmitIsHidden_shouldMutate() {
        Observable.just(true)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.isHidden)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.isHidden, true)
        
        Observable.just(false)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.isHidden)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.isHidden, false)
    }
    
    internal func testEmitIsEnabled_shouldMutate() {
        Observable.just(true)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.isEnabled)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.isEnabled, true)
        
        Observable.just(false)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.isEnabled)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.isEnabled, false)
    }
    
    internal func testEmitIsHighlighted_shouldMutate() {
        Observable.just(true)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.isHighlighted)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.isHighlighted, true)
        
        Observable.just(false)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.isHighlighted)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.isHighlighted, false)
    }
    
    internal func testEmitIsHighlighted_shouldObserve() {
        final class UITouchStub: UITouch {
            private let _tapCount: Int
            override var tapCount: Int {
                return self._tapCount
            }
            
            override init() {
                self._tapCount = 1 // becaused of ASControlNode.touchesBegan(_:with:)
                super.init()
            }
        }
        
        // given
        var isHighlighted: Bool = false
        sut.isEnabled = true
        sut.rx.isHighlighted
            .subscribe(onNext: { isHighlighted = $0 })
            .disposed(by: disposeBag)
        
        // when & then - Touch down/up/cancel
        sut.touchesBegan([UITouchStub()], with: nil)
        XCTAssertEqual(isHighlighted, true)
        
        sut.touchesBegan([UITouchStub()], with: nil)
        sut.touchesEnded([UITouchStub()], with: nil)
        XCTAssertEqual(isHighlighted, false)
        
        sut.touchesBegan([UITouchStub()], with: nil)
        sut.touchesCancelled([UITouchStub()], with: nil)
        XCTAssertEqual(isHighlighted, false)
    }
    
    internal func testEmitIsSelected_shouldMutate() {
        Observable.just(true)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.isSelected)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.isSelected, true)
        
        Observable.just(false)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.isSelected)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.isSelected, false)
    }
}

extension TestScheduler {
    /// Creates a `TestableObserver` instance which immediately subscribes
    /// to the `source` and disposes the subscription at virtual time 100000.
    internal func record<O: ObservableConvertibleType>(_ source: O) -> TestableObserver<O.Element> {
        let observer = self.createObserver(O.Element.self)
        let disposable = source.asObservable().bind(to: observer)
        self.scheduleAt(100_000) {
            disposable.dispose()
        }
        return observer
    }
}
