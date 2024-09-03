//
//  ClientViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 04.09.24.
//

import UIKit

class ClientViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    var client: ClientModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Client", button: nil)
        setupData()
    }
    
    func setupData() {
        guard let client = client else { return }
        statusImageView.image = (client.isRegularCustomer ?? false) ? UIImage(named: "RegularClient") : UIImage(named: "CustomClient")
        nameLabel.text = client.name
        descriptionLabel.text = client.description
        phoneNumberLabel.text = client.phoneNumber
        emailLabel.text = client.email
    }
    
    @IBAction func clickedBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
