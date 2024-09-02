//
//  ProjectTableViewCell.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var creatAtLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(model: ProjectModel) {
        projectNameLabel.text = model.project.name
        creatAtLabel.text = model.project.deadline
        let price = model.tasks.reduce(0) { $0 + (Double($1.price) ?? 0) }.formatNumber()
        priceLabel.text = "\(price) $"
    }
}
