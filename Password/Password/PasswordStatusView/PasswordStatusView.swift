
import UIKit

class PasswordStatusView: UIView {
    
    let stackView = UIStackView()
    let criteriaLabel = UILabel()
    
    let lengthCriteriaView = PasswordCriterialView(text: "8-32 characters (no spaces)")
    let uppercaseCriterialView = PasswordCriterialView(text: "uppercase letter (A-Z)")
    let lowerCaseCriterialView = PasswordCriterialView(text: "lowercase (a-z)")
    let digitCriterialView = PasswordCriterialView(text: "digit (0-9)")
    let specialCharacterCriterialView = PasswordCriterialView(text: "special character (e.g. !@#$%ˆ)")
    
    var shouldResetCriteria: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

// MARK: - Extensions
extension PasswordStatusView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        
        // StackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
        
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseCriterialView.translatesAutoresizingMaskIntoConstraints = false
        lowerCaseCriterialView.translatesAutoresizingMaskIntoConstraints = false
        digitCriterialView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriterialView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriterialView)
        stackView.addArrangedSubview(lowerCaseCriterialView)
        stackView.addArrangedSubview(digitCriterialView)
        stackView.addArrangedSubview(specialCharacterCriterialView)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
        ])
    }
    
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

        return attrText
    }
}

// MARK: - Actions
extension PasswordStatusView {
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        if shouldResetCriteria {
            // Inline validation (
            lengthAndNoSpaceMet ? lengthCriteriaView.isCriterialMet = true : lengthCriteriaView.reset()
            uppercaseMet ? uppercaseCriterialView.isCriterialMet = true : uppercaseCriterialView.reset()
            lowercaseMet ? lowerCaseCriterialView.isCriterialMet = true : lowerCaseCriterialView.reset()
            digitMet ? digitCriterialView.isCriterialMet = true : digitCriterialView.reset()
            specialCharacterMet ? specialCharacterCriterialView.isCriterialMet = true : specialCharacterCriterialView.reset()
        } else {
            lengthCriteriaView.isCriterialMet = lengthAndNoSpaceMet
            uppercaseCriterialView.isCriterialMet = uppercaseMet
            lowerCaseCriterialView.isCriterialMet = lowercaseMet
            digitCriterialView.isCriterialMet = digitMet
            specialCharacterCriterialView.isCriterialMet = specialCharacterMet
        }
    }
    
    func validate(_ text: String) -> Bool {
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        let checkable = [uppercaseMet, lowercaseMet, digitMet, specialCharacterMet]
        let metCriteria = checkable.filter { $0 }
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        
        if lengthAndNoSpaceMet && metCriteria.count >= 3 {
            return true
        }
        
        return false
    }
    
    func reset() {
        lengthCriteriaView.reset()
        uppercaseCriterialView.reset()
        lowerCaseCriterialView.reset()
        digitCriterialView.reset()
        specialCharacterCriterialView.reset()
    }
}

