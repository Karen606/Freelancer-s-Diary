//
//  ClientTableViewCell.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import UIKit

class ClientTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clientImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupData(client: ClientModel) {
        nameLabel.text = client.name
        if let isRegularCustomer = client.isRegularCustomer {
            clientImageView.image = isRegularCustomer ? UIImage(named: "RegularClient") : UIImage(named: "CustomClient")
        }
    }
    
}
