//
//  BaseVc.swift
//  KarmaScore
//
//  Created by AKASH on 07/11/23.
//

import UIKit

class BaseVc: UIViewController {
    //MARK: - @IBOutlet
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUi()
    }
    
    //MARK: - @IBAction
    
    //MARK: - Functions
    func setUi() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
