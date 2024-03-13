//
//  ThirdVm.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 13/03/24.
//

import Foundation

final class ThirdVm: ViewModel {
    // MARK: - Properties
    private var disposeBag = Bag()
    private var output = AppSubject<Output>()

    // MARK: - Life-Cycle

    // MARK: - Enums
    enum Input {
        case didTapButtonBack
    }

    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
    }

    // MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case .didTapButtonBack:
                strongSelf.router.pop(to: .main, with: nil, for: nil)
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
}
