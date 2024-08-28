//
//  TaskTableViewCell.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    func changeName(value: String, index: Int)
    func changePrice(value: String, index: Int)
    func updateTask(task: TaskModel, index: Int)
}

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNumberLabel: UILabel!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var priceTextField: CustomTextField!
    weak var delegate: TaskTableViewCellDelegate?
    private var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        nameTextField.delegate = self
        priceTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        priceTextField.text = nil
    }
    
    func setupData(task: TaskModel, number: Int) {
        taskNumberLabel.text = "Task \(number)"
        nameTextField.text = task.name
        if !task.price.isEmpty {
            priceTextField.text = "\(task.price)$"
        }
        self.index = number - 1
    }
}

extension TaskTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        delegate?.updateTask(task: TaskModel(name: nameTextField.text ?? "", price: priceTextField.text ?? ""), index: index)
        guard let value = textField.text else { return }
        switch textField {
        case nameTextField:
            delegate?.changeName(value: value, index: index)
        case priceTextField:
            delegate?.changePrice(value: value, index: index)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == priceTextField {
            if let value = textField.text, !value.isEmpty {
                priceTextField.text! += "$"
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == priceTextField {
            if let value = textField.text, !value.isEmpty && value.last == "$" {
                priceTextField.text?.removeLast()
            }
        }
    }
}
