//
//  AddToDoViewModel.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//  
//

import RxSwift
import RxCocoa

// MARK: - ViewModel protocols to communicate viewmodel to view controller
protocol AddToDoViewModelDelegate: class {
}

class AddToDoViewModel {
    private var disposeBag = DisposeBag()
    weak var delegate: AddToDoViewModelDelegate?
    
    var titleStr = BehaviorRelay<String>(value: "")
    var priorityStr = BehaviorRelay<String>(value: "")
    let dismissVC = PublishSubject<Void>()
    var bundle: [String: Any] = [:]
    fileprivate var todoData: ToDoRealm?

}
// ViewController to Presenter
extension AddToDoViewModel {
    /**
     Function to intialize data
     */
    func initData() {
        if let data = self.bundle[Constants.BundleConstants.todoData] as? ToDoRealm {
            todoData = data
            titleStr.accept(data.title)
            priorityStr.accept(data.priority)
        } else {
            priorityStr.accept(PriorityEnum.low.rawValue)
        }
    }
    
    /**
     Function to update data into database
     */
    func updateIntoDB() {
        if titleStr.value.isEmpty {
            AppDelegate.showToast(message: "Please enter TO-DO title")
            return
        }
        if let realmData = self.todoData {
            let realmObj = ToDoRealm(realmData.createdAt.value ?? 0, priority: priorityStr.value, title: titleStr.value)
            DBManager.shared.create(realmObj)
        } else {
            let realmObj = ToDoRealm(Date().timeIntervalSince1970, priority: priorityStr.value, title: titleStr.value)
            DBManager.shared.create(realmObj)
        }
        dismissTheViewController()
    }
    
    /**
     Function to dismiss the view controller
     */
    func dismissTheViewController() {
        dismissVC.asObserver().onNext(())
    }
}
