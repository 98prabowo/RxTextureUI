//
//  ASTextNodeTests.swift
//  
//
//  Created by Dimas Prabowo on 14/06/23.

import AsyncDisplayKit
import RxCocoa
import RxSwift
import RxTextureUI
import XCTest

internal final class ASTextNodeTests: XCTestCase {
    // MARK: - Variables
    
    internal var sut: ASTextNode!
    internal var disposeBag: DisposeBag!
    
    // MARK: - Setup
    
    override internal func setUp() {
        super.setUp()
        sut = ASTextNode()
        disposeBag = DisposeBag()
    }
    
    override internal func tearDown() {
        super.tearDown()
        sut = nil
        disposeBag = nil
    }
    
    // MARK: - Test Cases
    
    internal func testBindAttributedText_shouldMutate() {
        Observable<NSAttributedString?>.just(nil)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, "")
        
        Observable<NSAttributedString?>.just(.mockAttributedApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, .mockApple)
        
        Observable<NSAttributedString?>.just(.mockAttributedOrange)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.attributedText)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, .mockOrange)
    }
    
    internal func testBindTextWithAttributes_shouldMutate() {
        Observable<String?>.just(nil)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.text(nil))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, "")
        
        Observable<String?>.just(.mockApple)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.text(nil))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, "apple")
        
        Observable<String?>.just(.mockOrange)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.text(nil))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.attributedText?.string, "orange")
    }
}
