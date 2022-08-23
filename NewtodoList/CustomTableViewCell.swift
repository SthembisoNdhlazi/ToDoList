//
//  CustomTableViewCell.swift
//  NewtodoList
//
//  Created by Sthembiso Ndhlazi on 2022/08/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(task:String){
        cellLabel.text = task
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func isCheckedTapped(_ sender: Any) {
        
        if checkButton.currentImage == UIImage(named: "circleBadge"){
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
        if checkButton.currentImage == UIImage(named: "checkmark"){
            checkButton.setImage(UIImage(systemName: "circleBadge"), for: .normal)
        }
        
        
    }
    
}
