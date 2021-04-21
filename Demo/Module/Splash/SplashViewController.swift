//
//  SplashViewController.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//  
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController {
    // MARK: - IBOutlets
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: SplashViewModel!

    // MARK: - Superview Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initRxBinding()
        setupUI()
    }

}

// MARK: - Binding
extension SplashViewController {
    /**
     Function to initialize Rx binding
     */
    func initRxBinding() {
        
    }
    
}

// MARK: - UI Setup
extension SplashViewController {
    /**
     Function to setup ui elements
     */
    func setupUI() {
        
    }
}
// MARK: - ViewModel Delegate
extension SplashViewController: SplashViewModelDelegate {
    
}
