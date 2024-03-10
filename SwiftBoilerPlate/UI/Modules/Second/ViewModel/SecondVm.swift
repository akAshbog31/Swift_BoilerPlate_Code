//
//  SecondVm.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 10/03/24.
//

import Foundation

final class SecondVm: ViewModel {
    // MARK: - Properties
    private var disposeBag = Bag()
    private var output = AppSubject<Output>()

    // MARK: - Life-Cycle

    // MARK: - Enums
    enum Input {
        case popBack
    }

    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
    }

    // MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case .popBack:
                strongSelf.router.pop(with: nil, for: nil)
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
}
