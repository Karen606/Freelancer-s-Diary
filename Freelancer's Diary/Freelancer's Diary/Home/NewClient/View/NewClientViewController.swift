//
//  NewClientViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import UIKit
import Combine

class NewClientViewController: UIViewController {

    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var yesButton: UIButton!
    private let viewModel = NewClientViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private let nextButton = UIButton()
    private var selectedRegularCustomer: UIButton? {
        didSet {
            if oldValue != selectedRegularCustomer {
                selectedRegularCustomer?.isSelected = true
                oldValue?.isSelected = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Select a client", button: nextButton)
        nextButton.addTarget(self, action: #selector(clickedNextButton), for: .touchUpInside)
        nextButton.isEnabled = false
        bindViewModel()
        nameTextField.delegate = self
        descriptionTextView.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func bindViewModel() {
        viewModel.$newClient
            .receive(on: DispatchQueue.main)
            .sink { [weak self] project in
                self?.updateNextButtonState()
            }
            .store(in: &cancellables)
    }
    
    private func updateNextButtonState() {
        nextButton.isEnabled = viewModel.isFormValid
    }

    @IBAction func chooseRegularCusomer(_ sender: UIButton) {
        selectedRegularCustomer = sender
        viewModel.newClient.isRegularCustomer = sender == yesButton
    }
    
    @IBAction func clickedBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickedNextButton() {
        viewModel.saveClientToUserDefaults()
        ProjectViewModel.shared.client = viewModel.newClient
        ProjectViewModel.shared.saveProjectToUserDefaults()
        ProjectViewModel.shared.clear()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension NewClientViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            viewModel.newClient.name = textField.text ?? ""
        case phoneNumberTextField:
            viewModel.newClient.phoneNumber = textField.text ?? ""
        case emailTextField:
            viewModel.newClient.email = textField.text ?? ""
        default:
            break
        }
    }
}

extension NewClientViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        viewModel.newClient.description = textView.text
    }
}

extension NewClientViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
