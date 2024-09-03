//
//  RemoveConfirmationDialog.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 29.08.24.
//

import UIKit

protocol RemoveConfirmationDialogDelegate: AnyObject {
    func removeProject()
    func completeProject()
}

class RemoveConfirmationDialog: UIView {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    weak var delegate: RemoveConfirmationDialogDelegate?
    private var isRemove = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func commonInit(projectName: String?, isRemove: Bool = true) {
        self.isRemove = isRemove
        let descrition = isRemove ? "Are you sure you want to remove" : "Are you sure you want to complete?"
        self.descriptionLabel.text = "\(descrition) “\(projectName ?? "")”"
        self.backgroundColor = .systemBackground.withAlphaComponent(0.4)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.33).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
    }
  
    class func instanceFromNib() -> RemoveConfirmationDialog {
        return UINib(nibName: "RemoveConfirmationDialog", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RemoveConfirmationDialog
    }
    
    @IBAction func clickedYes(_ sender: UIButton) {
        if isRemove {
            delegate?.removeProject()
        } else {
            delegate?.completeProject()
        }
        self.removeFromSuperview()
    }
    
    @IBAction func clickedNo(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
}
