import UIKit

final class BirthdaysVC: UIViewController {
    
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private let notificationManager = NotificationManager()
    private let searchController = UISearchController(searchResultsController: nil)
    private let birthdaysTable = UITableView()
    private var filteredArray = [Birthday]()
    private var birthdayList = [Birthday]() {
        didSet {
            birthdaysTable.reloadData()
        }
    }
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupNC()
        setupBirthdaysTable()
        setupUI()
        addConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let birthdays = CoreDataManager.instance.getBirthday() else { return }
        birthdayList = birthdays
    }
    // MARK: - API
    // MARK: - Setups
    private func setupNC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Birthdays"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(buttonAddDidTapped)
        )
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .trash,
//            target: self,
//            action: #selector(buttonTrashDidTapped)
//        )
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    private func addSubviews() {
        view.addSubview(birthdaysTable)
    }
    
    private func setupBirthdaysTable() {
        birthdaysTable.delegate = self
        birthdaysTable.dataSource = self
        birthdaysTable.separatorStyle = .none
        birthdaysTable.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    private func setupUI() {
        
    }
    
    private func addConstraints() {
        birthdaysTable.translatesAutoresizingMaskIntoConstraints = false
        birthdaysTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        birthdaysTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        birthdaysTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        birthdaysTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // MARK: - Helpers
    @objc private func buttonAddDidTapped() {
        let addBirthdaysVC = AddBirthdayVC()
        navigationController?.pushViewController(addBirthdaysVC, animated: true)
    }
}

extension BirthdaysVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText: String) {
        filteredArray = birthdayList.filter({ (birthday: Birthday) -> Bool in
            return birthday.name.lowercased().contains(searchText.lowercased())
        })
        birthdaysTable.reloadData()
    }
}

extension BirthdaysVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArray.count
        }
        return birthdayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            
            if isFiltering {
                cell.set(filteredArray[indexPath.row])
            } else {
                cell.set(birthdayList[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            tableView.beginUpdates()
//            birthdayList.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .left)
//            tableView.endUpdates()
            
            CoreDataManager.instance.deleteEntity(usersArray: birthdayList, indexPath: indexPath)
            birthdayList.remove(at: indexPath.row)
            tableView.reloadData()
            
//            guard let birthdays = CoreDataManager.instance.getBirthday() else { return }
//            birthdayList = birthdays
            // let id = birthdays[indexPath.row].id
            // notificationCenter.delete(id: id)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("cell tapped")
    }
}
