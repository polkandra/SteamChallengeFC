
import UIKit

public class SteamLogin {
    public static var steamApiKey: String = ""
    
    public class func login(from vc: UIViewController, completion: @escaping SteamLoginVCHandler) {
        let loginVC = SteamLoginVC(loginHandler: completion)
        let navigationVC = UINavigationController(rootViewController: loginVC)
        vc.present(navigationVC, animated: true, completion: nil)
    }
}
