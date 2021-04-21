//
//  HomeViewController.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//  
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UITableViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel: HomeViewModel!

    // MARK: - Superview Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        initRxBinding()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getToDoList()
    }
    
    /**
     Function to register table view
     */
    private func registerTableView() {
        self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableView.automaticDimension
    }


}

// MARK: - Binding
extension HomeViewController {
    /**
     Function to initialize Rx binding
     */
    func initRxBinding() {
        addButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.redirectToAddToDo.onNext(())
            }).disposed(by: disposeBag)
        
        segmentControl.rx.selectedSegmentIndex.subscribe(onNext: { index in
            self.viewModel.segmentIndex = index
        }).disposed(by: disposeBag)
        
        viewModel.todoArray.asObservable().bind(to: tableView.rx.items(cellIdentifier: "HomeTableViewCell", cellType: HomeTableViewCell.self)) { (row, item, cell) in
            cell.updateUiElements(item)
            cell.deleteButton.rx.tap
                .subscribe(onNext: { _ in
                    self.viewModel.showDeleteAlert(self, item: item)
                }).disposed(by: cell.disposeBag)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(ToDoRealm.self).subscribe(onNext: { [weak self] item in
            self?.viewModel.redirectToEditToDo.onNext(item)
        }).disposed(by: disposeBag)

    }
    
}

// MARK: - UI Setup
extension HomeViewController {
    /**
     Function to setup ui elements
     */
    func setupUI() {
        
    }
}
// MARK: - ViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
    
}
