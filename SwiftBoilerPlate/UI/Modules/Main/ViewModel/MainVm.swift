//
//  MainVm.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 10/03/24.
//

import Foundation

final class MainVm: ViewModel {
    // MARK: - Properties
    var bag = Bag()
    var taskBag = TaskBag()
    var output = AppSubject<Output>()

    // MARK: - Enums
    enum Input {
        case viewDidLoad(imageData: Data)
        case navigateToSecondVc
    }

    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
    }

    // MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case let .viewDidLoad(imageData):
                strongSelf.sampleApiCallFunc(imageData: imageData)
            case .navigateToSecondVc:
                strongSelf.router.push(to: .second, with: .fade, for: 0.3)
            }
        }.store(in: &bag)
        return output.eraseToAnyPublisher()
    }

    private func sampleApiCallFunc(imageData: Data) {
        output.send(.loader(isLoading: true))
        Task {
            do {
                let name = "Test"
                let model = try await networkServices
                    .updateProfile(model: UpdateProfilePostModel(name: name, profileImage: imageData))
                print(model.data!)
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
