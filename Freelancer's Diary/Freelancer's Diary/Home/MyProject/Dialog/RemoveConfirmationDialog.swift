//
//  RemoveConfirmationDialog.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 29.08.24.
//

import UIKit

protocol RemoveConfirmationDialogDelegate: AnyObject {
    func removeProject()
}

class RemoveConfirmationDialog: UIView {
    weak var delegate: RemoveConfirmationDialogDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func commonInit() {
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
        delegate?.removeProject()
        self.removeFromSuperview()
    }
    
    @IBAction func clickedNo(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
}
