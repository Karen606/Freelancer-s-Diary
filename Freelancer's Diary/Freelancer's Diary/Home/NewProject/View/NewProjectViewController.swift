//
//  NewProjectViewController.swift
//  Freelancer's Diary
//
//  Created by Karen Khachatryan on 27.08.24.
//

import UIKit
import Combine
import FSCalendar

class NewProjectViewController: UIViewController {
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var deadlineButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextView!
    var viewModel = NewProjectViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private var calendar: FSCalendar!

    private let nextButton = UIButton()
    private var selectedPriority: UIButton? {
        didSet {
            if oldValue != selectedPriority {
                selectedPriority?.isSelected = true
                oldValue?.isSelected = false
            }
        }
    }
    private var selectedDifficulty: UIButton? {
        didSet {
            if oldValue != selectedDifficulty {
                selectedDifficulty?.isSelected = true
                oldValue?.isSelected = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setNavigationBar(title: "Add a new project", button: nextButton)
        nextButton.addTarget(self, action: #selector(clickedNextButton), for: .touchUpInside)
        nextButton.isEnabled = false
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        setupCalendar()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupCalendar() {
        calendar = FSCalendar()
        calendar.delegate = self
        calendar.appearance.headerTitleColor = .red
        calendar.appearance.weekdayTextColor = .systemGreen
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.todayColor = .systemOrange
        calendar.appearance.selectionColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        calendar.backgroundColor = #colorLiteral(red: 0.08965117445, green: 0.4313181619, blue: 0.8956617035, alpha: 1)
    }
    
    private func bindViewModel() {
        viewModel.$project
            .receive(on: DispatchQueue.main)
            .sink { [weak self] project in
                self?.updateNextButtonState()
            }
            .store(in: &cancellables)
    }
    
    private func updateNextButtonState() {
        nextButton.isEnabled = viewModel.isFormValid
    }

    
    @objc func clickedNextButton() {
        ProjectViewModel.shared.project = viewModel.project
        let tasksVC = TasksViewController(nibName: "TasksViewController", bundle: nil)
        self.navigationController?.pushViewController(tasksVC, animated: true)
    }
    
    @IBAction func chooseDeadline(_ sender: UIButton) {
        self.view.addSubview(calendar)

        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    calendar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    calendar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    calendar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    calendar.heightAnchor.constraint(equalToConstant: 300)
                ])
    }
    
    @IBAction func clickedBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func choosePriority(_ sender: UIButton) {
        selectedPriority = sender
        viewModel.project.priority = sender == yesButton
    }
    
    @IBAction func chooseDifficulty(_ sender: UIButton) {
        selectedDifficulty = sender
        switch sender {
        case easyButton:
            viewModel.project.difficulty = .easy
        case mediumButton:
            viewModel.project.difficulty = .medium
        case hardButton:
            viewModel.project.difficulty = .hard
        default:
            break
        }
    }
}

extension NewProjectViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.project.name = textField.text ?? ""
    }
}

extension NewProjectViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        viewModel.project.description = textView.text
    }
}

extension NewProjectViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd.MM.yyyy"
           let selectedDate = dateFormatter.string(from: date)
        self.deadlineButton.setTitle(selectedDate, for: .normal)
        self.deadlineButton.backgroundColor = UIColor(named: "SelectionColor")
        self.calendar.removeFromSuperview()
        viewModel.project.deadline = selectedDate
       }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return Date() < date
    }
}

extension NewProjectViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(view.hitTest(touch.location(in: view), with: nil)?.isDescendant(of: calendar) == true)
    }
}
