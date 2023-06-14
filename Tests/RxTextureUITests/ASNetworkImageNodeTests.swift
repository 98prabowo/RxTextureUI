//
//  ASNetworkImageNodeTests.swift
//  
//
//  Created by Dimas Prabowo on 14/06/23.

import AsyncDisplayKit
import RxCocoa
import RxSwift
import RxTextureUI
import XCTest

internal final class ASNetworkImageNodeTests: XCTestCase {
    // MARK: - Variables
    
    internal var sut: ASNetworkImageNode!
    internal var disposeBag: DisposeBag!
    
    // MARK: - Setup
    
    override internal func setUp() {
        super.setUp()
        sut = ASNetworkImageNode()
        disposeBag = DisposeBag()
    }
    
    override internal func tearDown() {
        super.tearDown()
        sut = nil
        disposeBag = nil
    }
    
    // MARK: - Test Cases
    
    internal func testBindURL_shouldMutate() {
        Observable<URL?>.just(nil)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.url)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.url, nil)
        
        Observable<URL>.just(.mockImageURL)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.url)
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.url, URL.mockImageURL)
    }
    
    internal func testBindURL_resetToDefault_shouldMutate() {
        Observable<URL?>.just(nil)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.url(resetToDefault: true))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.url, nil)
        
        Observable<URL>.just(.mockImageURL)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.url(resetToDefault: true))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.url, URL.mockImageURL)
        
        Observable<URL?>.just(nil)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.url(resetToDefault: false))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.url, nil)
        
        Observable<URL>.just(.mockImageURL)
            .asDriverOnErrorJustComplete()
            .drive(sut.rx.url(resetToDefault: false))
            .disposed(by: disposeBag)
        
        XCTAssertEqual(sut.url, URL.mockImageURL)
    }
}
