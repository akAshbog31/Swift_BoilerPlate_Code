//
//  ViewModel.swift
//  SwiftBoilerPlate
//
//  Created by AKASH on 22/11/23.
//

import Foundation

final class ViewModel {
    //MARK: - Properties
    var bag = Bag()
    var taskBag = TaskBag()
    var networkService: NetworkService
    var output = AppSubject<Output>()
    
    //MARK: - Life-Cycle
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    //MARK: - Enums
    enum Input {
        case viewDidLoad(imageData: Data)
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
    }
    
    //MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidLoad(let imageData):
                self?.sampleApiCallFunc(imageData: imageData)
            }
        }.store(in: &bag)
        return output.eraseToAnyPublisher()
    }
    
    private func sampleApiCallFunc(imageData: Data) {
        output.send(.loader(isLoading: true))
        Task {
            do {
                let model = try await networkService.updateProfile(model: UpdateProfilePostModel(name: "Test", profile_image: imageData))
                print(model.data)
                output.send(.loader(isLoading: false))
            } catch let error as APIError {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.description))
            } catch {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.localizedDescription))
            }
        }.store(in: &taskBag)
    }
}

