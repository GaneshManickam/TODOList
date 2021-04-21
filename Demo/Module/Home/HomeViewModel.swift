//
//  HomeViewModel.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//  
//

import RxSwift
import RxCocoa

// MARK: - ViewModel protocols to communicate viewmodel to view controller
protocol HomeViewModelDelegate: class {
}

class HomeViewModel {
    private var disposeBag = DisposeBag()
    weak var delegate: HomeViewModelDelegate?
    
    let redirectToAddToDo = PublishSubject<Void>()
    let redirectToEditToDo = PublishSubject<ToDoRealm>()
    var todoArray = BehaviorRelay<[ToDoRealm]>(value: [])
    
    var segmentIndex: Int = 0 {
        didSet {
            getToDoList()
        }
    }
}

extension HomeViewModel {
    /**
     Function to get todo list
     */
    func getToDoList() {
        DBManager.shared.read(ToDoRealm()) { (result) in
            let sortedResult = result.sorted(byKeyPath: "createdAt", ascending: false)
            var tempArray: [ToDoRealm] = []
            for item in sortedResult {
                tempArray.append(item)
            }
            if self.segmentIndex == 0 {
                self.todoArray.accept(tempArray)
            } else {
                var highArray: [ToDoRealm] = []
                var mediumArray: [ToDoRealm] = []
                var lowArray: [ToDoRealm] = []
                
                for item in tempArray {
                    if item.priority == PriorityEnum.low.rawValue {
                        lowArray.append(item)
                    } else if item.priority == PriorityEnum.medium.rawValue {
                        mediumArray.append(item)
                    } else if item.priority == PriorityEnum.high.rawValue {
                        highArray.append(item)
                    }
                }
                self.todoArray.accept(highArray+mediumArray+lowArray)
            }
        }
    }
    
    /**
     Function to show delete alert
     - PARAMETER vc: Instance of `UIViewController`
     - PARAMETER item: Instance of `ToDoRealm`
     */
    func showDeleteAlert(_ vc: UIViewController, item: ToDoRealm) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Delete", message: "Are you sure? You want to delete? \(item.title)", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default) {
                UIAlertAction in
                DBManager.shared.deleteObject(item)
                self.getToDoList()
            }
            let noAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) {
                UIAlertAction in
                print("Cancel")
            }
            alert.addAction(yesAction)
            alert.addAction(noAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
