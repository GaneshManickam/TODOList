//
//  HomeTableViewCell.swift
//  Demo
//
//  Created by Ganesh Manickam on 21/04/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension HomeTableViewCell {
    /**
     Function to update ui elements
     - PARAMETER item: Instance of ToDoRealm
     */
    func updateUiElements(_ item: ToDoRealm) {
        self.titleLabel.text = item.title
        let priority = item.priority
        self.priorityLabel.text = priority
        self.createdAtLabel.text = ""
        if let createdTimeStamp = item.createdAt.value {
            let dateObject = Date(timeIntervalSince1970: createdTimeStamp)
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd MMM, yyyy hh:mm:ss a"
            self.createdAtLabel.text = dateFormat.string(from: dateObject)
        }
        switch PriorityEnum(rawValue: priority) {
        case .low:
            self.priorityLabel.textColor = UIColor.green
            break
        case .medium:
            self.priorityLabel.textColor = UIColor.yellow
            break
        case .high:
            self.priorityLabel.textColor = UIColor.red
            break
        default:
            self.priorityLabel.textColor = UIColor.green
            break
        }
    }
}
