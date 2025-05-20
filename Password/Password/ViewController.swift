
import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let criterialView = PasswordCriterialView(text: "upercase letter (A-Z)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension ViewController {
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        
      // PasswordTextField
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        criterialView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
//        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(criterialView)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
}

