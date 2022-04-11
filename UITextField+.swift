import UIKit

extension UITextField {
    func setInputView(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(
            frame: CGRect(
                x: 0,
                y: 0,
                width: screenWidth,
                height: 220
            )
        )
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "Ru-ru")
        
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
