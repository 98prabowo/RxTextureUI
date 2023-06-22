//
//  ASDisplayNodeTests.swift
//  
//
//  Created by Dimas Prabowo on 14/06/23.

import AsyncDisplayKit
import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import RxTextureUI

internal final class ASDisplayNodeTests: XCTestCase {
    // MARK: - Helpers Types
    
    internal struct LifeCycleSpy: Equatable {
        internal var captured: [LifeCycle] = []
    }
    
    internal enum LifeCycle: Equatable {
        case didLoad
        case didEnterPreloadState
        case didEnterDisplayState
        case didEnterVisibleState
        case didExitVisibleState
        case didExitDisplayState
        case didExitPreloadState
    }
    
    // MARK: - Variables
    
    internal var sut: ASDisplayNode!
    internal var disposeBag: DisposeBag!
    
    internal var spy: LifeCycleSpy!
    internal var expected: LifeCycleSpy!
    
    // MARK: - Setup
    
    override internal func setUp() {
        super.setUp()
        sut = ASDisplayNode()
        disposeBag = DisposeBag()
        spy = LifeCycleSpy()
        expected = LifeCycleSpy()
    }
    
    override internal func tearDown() {
        super.tearDown()
        sut = nil
        disposeBag = nil
        spy = nil
        expected = nil
    }
    
    internal func setupLifeCycleTest() {
        sut.rx.didLoad
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] in
                self.spy.captured.append(.didLoad)
            })
            .disposed(by: disposeBag)
        
        sut.rx.didEnterPreloadState
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] in
                self.spy.captured.append(.didEnterPreloadState)
            })
            .disposed(by: disposeBag)
        
        sut.rx.didEnterDisplayState
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] in
                self.spy.captured.append(.didEnterDisplayState)
            })
            .disposed(by: disposeBag)
        
        sut.rx.didEnterVisibleState
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] in
                self.spy.captured.append(.didEnterVisibleState)
            })
            .disposed(by: disposeBag)
        
        sut.rx.didExitVisibleState
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] in
                self.spy.captured.append(.didExitVisibleState)
            })
            .disposed(by: disposeBag)
        
        sut.rx.didExitDisplayState
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] in
                self.spy.captured.append(.didExitDisplayState)
            })
            .disposed(by: disposeBag)
        
        sut.rx.didExitPreloadState
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [unowned self] in
                self.spy.captured.append(.didExitPreloadState)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Dimension Test Cases
    
    internal func testNodeHorizontalDimension_shouldMutate() {
        sut.rx.width.onNext(ASDimension(unit: .points, value: 17.0))
        XCTAssertEqual(sut.style.width.value, 17.0)
        
        sut.rx.minWidth.onNext(ASDimension(unit: .points, value: 15.0))
        XCTAssertEqual(sut.style.minWidth.value, 15.0)
        
        sut.rx.maxWidth.onNext(ASDimension(unit: .points, value: 20.0))
        XCTAssertEqual(sut.style.maxWidth.value, 20.0)
    }
    
    internal func testNodeVerticalDimension_shouldMutate() {
        sut.rx.height.onNext(ASDimension(unit: .points, value: 17.0))
        XCTAssertEqual(sut.style.height.value, 17.0)
        
        sut.rx.minHeight.onNext(ASDimension(unit: .points, value: 15.0))
        XCTAssertEqual(sut.style.minHeight.value, 15.0)
        
        sut.rx.maxHeight.onNext(ASDimension(unit: .points, value: 20.0))
        XCTAssertEqual(sut.style.maxHeight.value, 20.0)
    }
    
    internal func testNodePreferredDimension_shouldMutate() {
        let mockSize: CGSize = CGSize(width: 40.0, height: 40.0)
        sut.rx.preferredSize.onNext(mockSize)
        XCTAssertEqual(sut.style.preferredSize, mockSize)
    }
    
    // MARK: - Attribute Test Cases
    
    internal func testNodeAlpha_shouldMutate() {
        sut.rx.alpha.onNext(0.5)
        XCTAssertEqual(sut.alpha, 0.5)
        sut.rx.alpha.onNext(1.0)
        XCTAssertEqual(sut.alpha, 1.0)
    }
    
    internal func testNodeBackgroundColor_shouldMutate() {
        sut.rx.backgroundColor.onNext(.systemRed)
        XCTAssertEqual(sut.backgroundColor, .systemRed)
        sut.rx.backgroundColor.onNext(.systemBlue)
        XCTAssertEqual(sut.backgroundColor, .systemBlue)
    }
    
    internal func testNodeIsHidden_shouldMutate() {
        sut.rx.isHidden.onNext(true)
        XCTAssertEqual(sut.isHidden, true)
        sut.rx.isHidden.onNext(false)
        XCTAssertEqual(sut.isHidden, false)
    }
    
    internal func testNodeIsUserInteractionEnabled_shouldMutate() {
        sut.rx.isUserInteractionEnabled.onNext(true)
        XCTAssertEqual(sut.isUserInteractionEnabled, true)
        sut.rx.isUserInteractionEnabled.onNext(false)
        XCTAssertEqual(sut.isUserInteractionEnabled, false)
    }
    
    // MARK: - Lifecycles Test Cases
    
    internal func testNodeEnterDidLoad() {
        setupLifeCycleTest()
        sut.didLoad()
        expected.captured.append(.didLoad)
        XCTAssertEqual(spy, expected)
    }
    
    internal func testNodeEnterPreloadState() {
        setupLifeCycleTest()
        sut.didEnterPreloadState()
        expected.captured.append(.didEnterPreloadState)
        XCTAssertEqual(spy, expected)
    }
    
    internal func testNodeEnterDisplayState() {
        setupLifeCycleTest()
        sut.didEnterDisplayState()
        expected.captured.append(.didEnterDisplayState)
        XCTAssertEqual(spy, expected)
    }
    
    internal func testNodeEnterVisibleState() {
        setupLifeCycleTest()
        sut.didEnterVisibleState()
        expected.captured.append(.didEnterVisibleState)
        XCTAssertEqual(spy, expected)
    }
    
    internal func testNodeExitVisibleState() {
        setupLifeCycleTest()
        sut.didExitVisibleState()
        expected.captured.append(.didExitVisibleState)
        XCTAssertEqual(spy, expected)
    }
    
    internal func testNodeExitDisplayState() {
        setupLifeCycleTest()
        sut.didExitDisplayState()
        expected.captured.append(.didExitDisplayState)
        XCTAssertEqual(spy, expected)
    }
    
    internal func testExitPreloadState() {
        setupLifeCycleTest()
        sut.didExitPreloadState()
        expected.captured.append(.didExitPreloadState)
        XCTAssertEqual(spy, expected)
    }
}
