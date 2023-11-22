//
//  BaseVm.swift
//  KarmaScore
//
//  Created by AKASH on 21/11/23.
//

import Foundation

@MainActor protocol BaseVm {
    associatedtype Output
    associatedtype Input
    
    var disposeBag: Bag { get set }
    var networkService: NetworkService { get }
    var output: AppSubject<Output> { get set }
    
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output>
}
