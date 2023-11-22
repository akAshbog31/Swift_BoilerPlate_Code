//
//  ViewModel.swift
//  SwiftBoilerPlate
//
//  Created by AKASH on 22/11/23.
//

import Foundation

final class ViewModel: BaseVm {
    //MARK: - Properties
    var disposeBag = Bag()
    var networkService: NetworkService
    var output = AppSubject<Output>()
    
    //MARK: - Life-Cycle
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    //MARK: - Enums
    enum Input {
        case viewDidLoad
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
    }
    
    //MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad:
                self?.sampleApiCallFunc()
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
    
    private func sampleApiCallFunc() {
        output.send(.loader(isLoading: true))
        Task {
            do {
                let model = try await networkService.testAPI()
                output.send(.loader(isLoading: false))
            } catch let error as APIError {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.description))
            } catch {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: "Test"))
            }
        }
    }
}

