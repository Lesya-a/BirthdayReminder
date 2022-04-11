import UIKit

enum MaximumDate {
    case yes
    case no
}

extension UITextField {
    func setInputView(target: Any, selector: Selector, format: UIDatePicker.Mode = .date, maxDate: MaximumDate = .yes) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(
            frame: CGRect(
                x: 0,
                y: 0,
                width: screenWidth,
                height: 220
            )
        )
        
        //datePicker.maximumDate = Date()
        datePicker.datePickerMode = format
        datePicker.locale = Locale(identifier: "Ru-ru")
        datePicker.timeZone = .autoupdatingCurrent
        
        switch maxDate {
        case .no:
            datePicker.maximumDate = .none
        case .yes:
            datePicker.maximumDate = Date()
        }
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        inputView = datePicker
        
        //accesory view
        
        let toolBar = UIToolbar(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: screenWidth,
                height: 44
            )
        )
        let spacing = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let cancel = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: nil,
            action: #selector(tapCancel)
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: target,
            action: selector
        )
        toolBar.setItems([cancel, spacing, doneButton], animated: false)
        inputAccessoryView = toolBar
    }
    @objc func tapCancel() {
        //becomeFirstResponder()
        resignFirstResponder()
    }
}
