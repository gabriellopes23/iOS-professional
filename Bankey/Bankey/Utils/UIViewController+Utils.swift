
import UIKit
 
extension UIViewController {
    func setStatusBar() {
        let navBarApparence = UINavigationBarAppearance()
        navBarApparence.configureWithTransparentBackground()
        navBarApparence.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navBarApparence
        UINavigationBar.appearance().scrollEdgeAppearance = navBarApparence
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
