//
//  AddToDoCoordinator.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//  
//

import RxSwift

class AddToDoCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    private var bundle: [String: Any] = [:]
    
    init(rootViewController: UIViewController, bundle: [String: Any]) {
        self.rootViewController = rootViewController
        self.bundle = bundle
    }
    
    override func start() throws -> Observable<Void> {
        
        let viewController = AddToDoViewController()
        let viewModel = AddToDoViewModel()
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        viewController.viewModel.bundle = self.bundle
        
        bindLifecycle(for: viewController)
        bindViewModel(for: viewModel, vc: viewController)
        rootViewController.pushTo(viewController, animated: true)
        return Observable.empty()
    }
    
}
// MARK: - Bind View controller lifecycle and viewmodel
extension AddToDoCoordinator {
    /**
     Function to bind lifecycle for the view controller
     - PARAMETER viewController: Instance of View Controller
     */
    func bindLifecycle(for viewController: AddToDoViewController) {
        
        viewController.rx.viewWillAppear
            .subscribe(onNext: { _ in
                
            })
            .disposed(by: disposeBag)
    }
    
    /**
     Function to bind view model
     - PARAMETER viewModel: Instance of View Model
     - PARAMETER vc: Instance of View Controller
     */
    func bindViewModel(for viewModel: AddToDoViewModel, vc: AddToDoViewController) {
        
        viewModel.dismissVC.asObservable().subscribe(onNext: { _ in
            vc.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}
