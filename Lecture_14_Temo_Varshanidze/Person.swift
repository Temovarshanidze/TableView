import UIKit

protocol PersonInputInfoDelegate: AnyObject {
    func configure (person : Person)
}

struct Person  {
    var firstName: String
    var lastName: String
    var age: Int
}
