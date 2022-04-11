import UIKit

final class TableViewCell: UITableViewCell {
    // MARK: - Properties
    // MARK: Public

    // MARK: Private
    private let view = UIView()
    private let stackViewName = UIStackView()
    private let nameLabel = UILabel()
    private let surnameLabel = UILabel()
    private let birthDateLabel = UILabel()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupUI()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - API
    func set(_ user: Birthday) {
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd MMMM"
        let releasingDate = dateFormatter.string(from: user.birthDate)

        birthDateLabel.text = releasingDate
    }

    // MARK: - Setups
    private func addSubviews() {
        contentView.addSubview(view)
        contentView.addSubview(stackViewName)
        contentView.addSubview(birthDateLabel)
        stackViewName.addArrangedSubview(nameLabel)
        stackViewName.addArrangedSubview(surnameLabel)
    }

    private func setupUI() {
        viewUI()
        stackViewNameUI()
        nameLabelUI()
        surnameLabelUI()
        birthDateLabelUI()
    }

    private func viewUI() {
        view.backgroundColor = UIColor(displayP3Red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 0.3)
        view.layer.borderWidth = 0.2
        view.layer.borderColor = CGColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1)
        view.layer.cornerRadius = 8
    }

    private func stackViewNameUI() {
        stackViewName.axis = .vertical
        stackViewName.distribution = .fillEqually
        stackViewName.spacing = 10
        //stackViewName.backgroundColor = .black
    }

    private func nameLabelUI() {
        //nameLabel.backgroundColor = .blue
        nameLabel.textAlignment = .center
    }

    private func surnameLabelUI() {
        //surnameLabel.backgroundColor = .green
        surnameLabel.textAlignment = .center
    }

    private func birthDateLabelUI() {
        //birthDateLabel.backgroundColor = .orange
        birthDateLabel.textAlignment = .center
    }

    private func addConstraints() {
        viewConstraints()
        stackViewNameConstraints()
        nameTextLabelConstraints()
        surnameTextLabelConstraints()
        birthDateTextLabelConstraints()
    }

    private func viewConstraints() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }

    private func stackViewNameConstraints() {
        stackViewName.translatesAutoresizingMaskIntoConstraints = false
        stackViewName.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackViewName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        stackViewName.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        stackViewName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }

    private func nameTextLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func surnameTextLabelConstraints() {
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func birthDateTextLabelConstraints() {
        birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        birthDateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        birthDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        birthDateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }

    // MARK: - Helpers
}
