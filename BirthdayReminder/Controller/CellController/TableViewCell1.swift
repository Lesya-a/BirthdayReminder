import UIKit

final class TableViewCell1: UITableViewCell {
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let dateOfBirth = UITextField()
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubviews()
        setupUI()
        addConstraints()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - API
    // MARK: - Setups
    private func addSubviews() {}
    
    private func setupUI() {}
    
    private func addConstraints() {}
    
    // MARK: - Helpers
    
    
}
