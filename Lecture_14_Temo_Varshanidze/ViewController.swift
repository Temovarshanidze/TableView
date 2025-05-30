import UIKit



class ViewController: UIViewController {
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Age"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Person", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        return button
    }()
    private let sortbtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("sort by  age", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        return button
    }()
    private let unsortbtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("unsort", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .green
        label.text = ""
        return label
    }()
    
    private var people: [Person] = []
    private var secondpeople: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = .cyan
        
        view.addSubview(nameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(ageTextField)
        view.addSubview(addButton)
        view.addSubview(sortbtn)
        view.addSubview(unsortbtn)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            ageTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            ageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 120),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            
            sortbtn.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            sortbtn.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -15),
            sortbtn.widthAnchor.constraint(equalToConstant: 120),
            sortbtn.heightAnchor.constraint(equalToConstant: 40),
            
            unsortbtn.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            unsortbtn.leftAnchor.constraint(equalTo: addButton.rightAnchor, constant: 15),
            unsortbtn.widthAnchor.constraint(equalToConstant: 120),
            unsortbtn.heightAnchor.constraint(equalToConstant: 40),
            
            
            
        ])
        addButton.addAction(UIAction(handler: { [weak self] _ in
            self?.addPerson()
        }), for: .touchUpInside)
        
        sortbtn.addAction(UIAction(handler: { [weak self] _ in
            // self?.addPerson()
            self?.people.sort { $0.age < $1.age }
            self?.mainTableView.reloadData()
        }), for: .touchUpInside)
        unsortbtn.addAction(UIAction(handler: { [weak self] _ in
            self?.people = self!.secondpeople
            self?.mainTableView.reloadData()
        }), for: .touchUpInside)
    }
    
    private   func addPerson() {
        
        if nameTextField.text!.isEmpty == false && lastNameTextField.text!.isEmpty == false && ageTextField.text!.isEmpty == false {
            let firstName = nameTextField.text!
            let lastName = lastNameTextField.text!
            guard let age = Int(ageTextField.text!) else { errorLabel.text = "Age must be a number"; mainTableView.addSubview(errorLabel); return }
            let newPerson = Person(firstName: firstName, lastName: lastName, age: age )
            people.append(newPerson)
            secondpeople.append(newPerson)
        }
        else{
            errorLabel.text = "Please fill all fields"
            mainTableView.addSubview(errorLabel)
        }
        if nameTextField.text!.isEmpty == false && lastNameTextField.text!.isEmpty == false && ageTextField.text!.isEmpty == false {
            
            errorLabel.removeFromSuperview()
        }
        
        mainTableView.reloadData()
        nameTextField.text = ""
        lastNameTextField.text = ""
        ageTextField.text = ""
    }
    
    
    private func setupTableView() {
        view.addSubview(mainTableView)
        mainTableView.backgroundColor = .yellow
        mainTableView.register(PersonFullInfo.self, forCellReuseIdentifier: "PersonFullInfo")
        mainTableView.dataSource = self
        mainTableView.backgroundView = errorLabel
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: mainTableView.topAnchor, constant: 30).isActive = true
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonFullInfo", for: indexPath) as? PersonFullInfo
        let person = people[indexPath.row]
        cell?.configure(person: person)
        return cell ?? UITableViewCell()
    }
    
}

