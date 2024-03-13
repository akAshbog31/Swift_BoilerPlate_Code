//
//  ThirdVc.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 13/03/24.
//

import UIKit

class ThirdVc: ViewController<ThirdVm> {
    // MARK: - @IBOutlets

    // MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<ThirdVm.Input>()

    // MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    // MARK: - @IBActions
    @IBAction func didTapButtonBack(_: Any) {
        input.send(.didTapButtonBack)
    }

    // MARK: - Functions
    private func bindViewModel() {
        viewModel.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            }
        }.store(in: &disposeBag)
    }
}
