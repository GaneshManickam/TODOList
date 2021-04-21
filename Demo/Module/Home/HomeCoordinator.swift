//
//  HomeCoordinator.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//  
//

import RxSwift

class HomeCoordinator: BaseCoordinator<Void> {
    
    private let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() throws -> Observable<Void> {
        
        let viewController = HomeViewController()
        let viewModel = HomeViewModel()
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        
        bindLifecycle(for: viewController)
        bindViewModel(for: viewModel, vc: viewController)
        rootViewController.pushTo(viewController, animated: true)
        return Observable.empty()
    }
    
}
// MARK: - Bind View controller lifecycle and viewmodel
extension HomeCoordinator {
    /**
     Function to bind lifecycle for the view controller
     - PARAMETER viewController: Instance of View Controller
     */
    func bindLifecycle(for viewController: HomeViewController) {
        
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
    func bindViewModel(for viewModel: HomeViewModel, vc: HomeViewController) {
        viewModel.redirectToAddToDo.asObservable().subscribe(onNext: { _ in
            self.redirectToAddToDo(on: vc, bundle:[:])
        }).disposed(by: disposeBag)
        
        viewModel.redirectToEditToDo.asObservable().subscribe(onNext: { item in
            let bundle: [String: Any] = [
                Constants.BundleConstants.todoData: item
            ]
            self.redirectToAddToDo(on: vc, bundle:bundle)
        }).disposed(by: disposeBag)


        
    }
}

extension HomeCoordinator {
    /**
     Function to redirect to add todo
     - PARAMETER vc: Instance of `UIViewController`
     */
    private func redirectToAddToDo(on vc: UIViewController, bundle: [String: Any]) {
        let coordinator = AddToDoCoordinator(rootViewController: vc, bundle: bundle)
        self.coordinate(to: coordinator)
    }
}
