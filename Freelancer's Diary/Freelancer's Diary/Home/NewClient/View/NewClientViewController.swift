//
//  NewClientViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 28.08.24.
//

import UIKit
import Combine

class NewClientViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    @IBOutlet weak var emailTextField: EmailTextField!
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
        registerKeyboardNotifications()
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case phoneNumberTextField:
            phoneNumberTextField.isValidPhoneNumber()
        case emailTextField:
            emailTextField.isValidEmail()
        default:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            return phoneNumberTextField.textField(phoneNumberTextField, shouldChangeCharactersIn: range, replacementString: string)
        }
        return true
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

extension NewClientViewController {
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(NewClientViewController.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                scrollView.contentInset = .zero
            } else {
                let height: CGFloat = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)!.size.height
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            }
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}
