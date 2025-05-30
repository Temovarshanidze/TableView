import UIKit

class PersonFullInfo: UITableViewCell {
    private let nameLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
         label.textColor = .black
         return label
     }()
     
     private let lastNameLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
         label.textColor = .darkGray
         return label
     }()
     
     private let ageLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
         label.textColor = .blue
         return label
     }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBlue
        setUpUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpUI() {
           contentView.addSubview(nameLabel)
           contentView.addSubview(lastNameLabel)
           contentView.addSubview(ageLabel)
           
           NSLayoutConstraint.activate([
               nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
               nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               
               lastNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
               lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               
               ageLabel.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 5),
               ageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               ageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
           ])
       }
}

extension PersonFullInfo:PersonInputInfoDelegate {
    func configure(person: Person) {
        nameLabel.text = "Name: \(person.firstName)"
        lastNameLabel.text = "Last Name: \(person.lastName)"
        ageLabel.text = "Age: \(person.age)"
    }

}

