//
//  AddToDoViewController.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//  
//

import UIKit
import RxSwift
import RxCocoa

class AddToDoViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: AddToDoViewModel!
    
    fileprivate var pickerView = UIPickerView()

    // MARK: - Superview Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initRxBinding()
        initData()
    }

}

// MARK: - Binding
extension AddToDoViewController {
    /**
     Function to initialize Rx binding
     */
    func initRxBinding() {
        backButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.dismissTheViewController()
            }).disposed(by: disposeBag)
        
        titleTextField.rx.text
            .map { ($0 ?? "") }
            .bind(to: viewModel.titleStr)
            .disposed(by: disposeBag)

        viewModel.titleStr
          .filter { $0 != self.titleTextField.text }
          .bind(to: titleTextField.rx.text)
          .disposed(by: disposeBag)
        
        priorityTextField.rx.text
            .map { ($0?.trimmingCharacters(in: CharacterSet.whitespaces) ?? "") }
            .bind(to: viewModel.priorityStr)
            .disposed(by: disposeBag)
        
        viewModel.priorityStr
          .filter { $0 != self.priorityTextField.text }
          .bind(to: priorityTextField.rx.text)
          .disposed(by: disposeBag)

        Observable.just([PriorityEnum.low.rawValue, PriorityEnum.medium.rawValue, PriorityEnum.high.rawValue])
                        .bind(to: pickerView.rx.itemTitles) { _, item in
                            return "\(item)"
                        }
                        .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .subscribe(onNext: { [weak self] models in
                if let firstItem = models.first {
                    self?.viewModel.priorityStr.accept(firstItem)
                }
            })
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.updateIntoDB()
            }).disposed(by: disposeBag)
    }
    
    /**
     Function to initialize data
     */
    func initData() {
        self.viewModel.initData()
    }

}

// MARK: - UI Setup
extension AddToDoViewController {
    /**
     Function to setup ui elements
     */
    func setupUI() {
        self.priorityTextField.inputView = pickerView
    }
}
// MARK: - ViewModel Delegate
extension AddToDoViewController: AddToDoViewModelDelegate {
    
}
