//
//  CustomTableViewCell.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/22.
//

import UIKit

protocol isDone{
    func toggleIsDone(for cell:UITableViewCell)
}


class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    var isDoneDelegate:isDone?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let models = [NewTask]()
    
    func setUpCell(task: String, isDone: Bool){
        cellLabel.text = task
        
        if isDone{
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else{
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func isCheckedTapped(_ sender: Any) {
        
        print("tapped")
        
        isDoneDelegate?.toggleIsDone(for: self)
        
        
        
    }
    
}
