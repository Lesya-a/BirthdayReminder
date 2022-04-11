import UIKit

final class AddBirthdayVC: UIViewController {
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private let dateView = UIView()
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let birthDateLabel = UILabel()
    private let birthDateTextField = UITextField()
    private let notificationLabel = UILabel()
    private let notificationTextField = UITextField()
    private let saveButton = UIButton()
    
    private let notificationManager = NotificationManager()
    private var hours: Int = -1
    private var minutes: Int = -1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupNC()
        setupUI()
        addConstraints()
        birthDateTextField.setInputView(
            target: self,
            selector: #selector(dateTapped)
        )
        notificationTextField.setInputView(
            target: self,
            selector: #selector(timeTapped),
            format: .time,
            maxDate: .no
        )
    }
    // MARK: - API
    // MARK: - Setups
    private func setupNC() {
        navigationItem.title = "New entry"
    }
    
    private func addSubviews() {
        view.addSubview(dateView)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(birthDateLabel)
        view.addSubview(birthDateTextField)
        view.addSubview(notificationLabel)
        view.addSubview(notificationTextField)
        view.addSubview(saveButton)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        nameTextFieldUI()
        surnameTextFieldUI()
        birthDateLabelUI()
        birthDateTextFieldUI()
        notificationLabelUI()
        notificationTextFieldUI()
        saveButtonUI()
    }
    private func nameTextFieldUI() {
        nameTextField.layer.cornerRadius = 20
        nameTextField.layer.borderWidth = 0.1
        nameTextField.placeholder = "Name"
        nameTextField.textAlignment = .center
    }
    private func surnameTextFieldUI() {
        surnameTextField.layer.cornerRadius = 20
        surnameTextField.layer.borderWidth = 0.1
        surnameTextField.placeholder = "Surname"
        surnameTextField.textAlignment = .center
    }
    private func birthDateLabelUI() {
        birthDateLabel.font = birthDateLabel.font.withSize(22)
        birthDateLabel.text = "Choose a birthday:"
        birthDateLabel.textAlignment = .center
        birthDateLabel.contentMode = .bottom
    }
    private func birthDateTextFieldUI() {
        birthDateTextField.layer.cornerRadius = 20
        birthDateTextField.layer.borderWidth = 0.1
        birthDateTextField.placeholder = "Date"
        birthDateTextField.textAlignment = .center
    }
    private func notificationLabelUI() {
        notificationLabel.font = birthDateLabel.font.withSize(22)
        notificationLabel.text = "Choose time of notification:"
        notificationLabel.textAlignment = .center
        notificationLabel.contentMode = .bottom
    }
    private func notificationTextFieldUI() {
        notificationTextField.layer.cornerRadius = 20
        notificationTextField.layer.borderWidth = 0.1
        notificationTextField.placeholder = "Time"
        notificationTextField.textAlignment = .center
    }
    private func saveButtonUI() {
        saveButton.backgroundColor = .systemGray5
        saveButton.layer.cornerRadius = 20
        saveButton.setTitle(
            "Save",
            for: .normal
        )
        saveButton.setTitleColor(
            .black,
            for: .normal
        )
        saveButton.addTarget(
            self,
            action: #selector(buttonSaveDidTapped),
            for: .touchUpInside
        )
    }
    
    private func addConstraints() {
        dateViewConstraints()
        nameTextFieldConstraints()
        surnameTextFieldConstraints()
        birthDateLabelConstraints()
        birthDateTextFieldConstraints()
        notificationLabelConstraints()
        notificationTextFieldConstraints()
        saveButtonConstraints()
    }
    private func dateViewConstraints() {
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dateView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        dateView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32).isActive = true
    }
    private func nameTextFieldConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 30).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func surnameTextFieldConstraints() {
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        surnameTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        surnameTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        surnameTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
    }
    private func birthDateLabelConstraints() {
        birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDateLabel.leadingAnchor.constraint(equalTo: surnameTextField.leadingAnchor).isActive = true
        birthDateLabel.trailingAnchor.constraint(equalTo: surnameTextField.trailingAnchor).isActive = true
        birthDateLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor).isActive = true
        birthDateLabel.heightAnchor.constraint(equalTo: surnameTextField.heightAnchor).isActive = true
    }
//    private func datePickerConstraints() {
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        datePicker.topAnchor.constraint(equalTo: dateView.bottomAnchor).isActive = true
//        datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
//        datePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
//    }
    private func birthDateTextFieldConstraints() {
        birthDateTextField.translatesAutoresizingMaskIntoConstraints = false
        birthDateTextField.topAnchor.constraint(equalTo: dateView.bottomAnchor).isActive = true
        birthDateTextField.leadingAnchor.constraint(equalTo: birthDateLabel.leadingAnchor).isActive = true
        birthDateTextField.trailingAnchor.constraint(equalTo: birthDateLabel.trailingAnchor).isActive = true
        birthDateTextField.heightAnchor.constraint(equalTo: birthDateLabel.heightAnchor).isActive = true
    }
    private func notificationLabelConstraints() {
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor, constant: 10).isActive = true
        notificationLabel.leadingAnchor.constraint(equalTo: birthDateLabel.leadingAnchor).isActive = true
        notificationLabel.trailingAnchor.constraint(equalTo: birthDateLabel.trailingAnchor).isActive = true
        notificationLabel.heightAnchor.constraint(equalTo: birthDateLabel.heightAnchor).isActive = true
        
    }
    private func notificationTextFieldConstraints() {
        notificationTextField.translatesAutoresizingMaskIntoConstraints = false
        notificationTextField.topAnchor.constraint(equalTo: notificationLabel.bottomAnchor, constant: 10).isActive = true
        notificationTextField.leadingAnchor.constraint(equalTo: birthDateTextField.leadingAnchor).isActive = true
        notificationTextField.trailingAnchor.constraint(equalTo: birthDateTextField.trailingAnchor).isActive = true
        notificationTextField.heightAnchor.constraint(equalTo: birthDateTextField.heightAnchor).isActive = true
        
    }
    private func saveButtonConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    // MARK: - Helpers
    @objc private func buttonSaveDidTapped() {
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let birthDate = dateFormatter.date(from: birthDateTextField.text!) ?? Date()
        let date = Birthday(name: name, surname: surname, birthDate: birthDate)
        
        CoreDataManager.instance.saveBirthday(date)
        notificationManager.notification(name: date.name, id: date.id, date: date.birthDate, hour: hours, minute: minutes)
        
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func dateTapped() {
        if let datePicker = birthDateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd/MMMM/YYYY"
            birthDateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        birthDateTextField.resignFirstResponder()
    }
    
    @objc private func timeTapped() {
        if let datePicker = notificationTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "HH:mm"
            notificationTextField.text = dateFormatter.string(from: datePicker.date)
        }
        notificationTextField.resignFirstResponder()
    }

}

