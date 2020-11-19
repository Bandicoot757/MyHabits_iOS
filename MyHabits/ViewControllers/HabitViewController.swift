//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Stanislav Leontyev on 04.11.2020.
//

import UIKit

class HabitViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        colorPicker.delegate = self
    }
    
    //MARK: - Views
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar: UINavigationBar = UINavigationBar()
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .customMagenta
        let navigationItem = UINavigationItem(title: "Создать")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelNavBarButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveNavBarButtonTapped))
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
     lazy var nameTextField: UITextField = {
        let nameTextField: UITextField = UITextField()
        nameTextField.placeholder = "Бегать по утрам, спать 8 часов и т.д."
        return nameTextField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Цвет"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
     lazy var colorButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .customMagenta
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(setColorButtonTapped), for: .touchUpInside)
        return button
    }()
    
     private lazy var dateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
     lazy var editDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Каждый день в \(timeFormatter())"
        var mutableTextlabel = NSMutableAttributedString()
        mutableTextlabel = NSMutableAttributedString(string: label.text!, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17, weight: .regular)])
        mutableTextlabel.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.customMagenta, range: NSRange(location:13, length: mutableTextlabel.length-13))
        label.attributedText = mutableTextlabel
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(datePickerDateSelected), for: .allEvents)
        return datePicker
    }()
    
    lazy var deleteHabitButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(showAlertController), for: .touchUpInside)
        return button
    }()
    
    override func viewWillLayoutSubviews() {
        
        view.addSubviews(navigationBar)
        view.addSubviews(nameLabel)
        view.addSubviews(nameTextField)
        view.addSubviews(colorLabel)
        view.addSubviews(colorButton)
        view.addSubviews(dateLabel)
        view.addSubviews(editDateLabel)
        view.addSubviews(datePicker)
        view.addSubviews(deleteHabitButton)
        
        NSLayoutConstraint.activate([
        
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 44),
            nameLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -7),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.bottomAnchor.constraint(equalTo: colorLabel.topAnchor, constant: -15),
            
            colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.bottomAnchor.constraint(equalTo: colorButton.topAnchor, constant: -15),
            
            colorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 15),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            dateLabel.bottomAnchor.constraint(equalTo: editDateLabel.topAnchor, constant: -15),
            
            editDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            editDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            editDateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            editDateLabel.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -15),
            
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: editDateLabel.bottomAnchor, constant: 15),
            
            deleteHabitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteHabitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            deleteHabitButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    //MARK: Date settings
    
    let dateFormatter = DateFormatter()
    
    func timeFormatter() -> String {
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = .current
        let convertedTime = dateFormatter.string(from: datePicker.date)
        return convertedTime
    }
    
    func dateFromString() -> Date {
        let string = timeFormatter()
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    func showHabitsViewController() {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: HabitsViewController.self))
        destinationVC?.modalPresentationStyle = .fullScreen
        self.present(destinationVC!, animated: true, completion: nil)
    }
    
    
    //MARK: - Pickers
    
    // Здесь я не понял, нужно сделать выбор только цвета из стилей задания или все. Пока оставил все.
    let colorPicker = UIColorPickerViewController()
    
    //MARK: - @objc methods

    
    @objc func saveNavBarButtonTapped(){
        
        if deleteHabitButton.isHidden == true {
            guard let name = nameTextField.text else {return}
            guard let color = colorButton.backgroundColor else {return}
        
            let newHabit = Habit(name: name, date: dateFromString(), color: color)
        
            let store = HabitsStore.shared
            store.habits.append(newHabit)
        
            dismiss(animated: true, completion: nil)
        } else {
            let thisHabit = HabitsStore.shared.habits[Manager.shared.index!]
            thisHabit.name = nameTextField.text!
            thisHabit.color = colorButton.backgroundColor!
            thisHabit.date = dateFromString()
            showHabitsViewController()
        }
        
    }
    
    @objc func cancelNavBarButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func setColorButtonTapped() {
        present(colorPicker, animated: true, completion: nil)
    }
    
    @objc func datePickerDateSelected() {
        let selectedTime = timeFormatter()
        editDateLabel.text = "Каждый день в \(selectedTime)"
        var mutableTextlabel = NSMutableAttributedString()
        mutableTextlabel = NSMutableAttributedString(string: editDateLabel.text!, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17, weight: .regular)])
        mutableTextlabel.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.customMagenta, range: NSRange(location:13, length: mutableTextlabel.length-13))
        editDateLabel.attributedText = mutableTextlabel
    }
    
    @objc func showAlertController() {
        
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку ?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            HabitsStore.shared.habits.remove(at: Manager.shared.index!)
            self.showHabitsViewController()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

    //MARK: - Extensions

extension HabitViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorButton.backgroundColor = colorPicker.selectedColor
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}

