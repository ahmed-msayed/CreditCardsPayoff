
import UIKit
import FirebaseAuth
import FirebaseFirestore

//-----------------------------------------------------------------------------------------------------------------------------------------------
class LoginVC: UIViewController {
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSubTitle: UILabel!
    @IBOutlet var imageViewLogo: UIImageView!
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var buttonHideShowPassword: UIButton!
    
    let db = Firestore.firestore()
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        textFieldEmail.setLeftPadding(value: 15)
        textFieldPassword.setLeftPadding(value: 15)
        textFieldPassword.setRightPadding(value: 40)
        
        loadData()
    }
    
    func getUserData(userId: String) {
        db.collection("users").whereField("userId", isEqualTo: userId)
            .getDocuments() { [weak self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let data = document.data()
                        if let firstName = data["firstName"] as? String, let lastName = data["lastName"] as? String {
                            UserDefaults.standard.setFirstName(value: firstName)
                            UserDefaults.standard.setLastName(value: lastName)
                            UserDefaults.standard.setUserID(value: userId)
                            UserDefaults.standard.setLoggedIn(value: true)
                            
                            self?.goToHomeVC()
                        }
                    }
                }
            }
    }
    
    func goToHomeVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
        
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
    }
    
    // MARK: - Data methods
    //-------------------------------------------------------------------------------------------------------------------------------------------
    func loadData() {
        
        labelTitle.text = "Welcome to\nAppDesignKit"
        labelSubTitle.text = "An exciting place for the whole family to shop."
    }
    
    // MARK: - User actions
    //-------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionHideShowPassword(_ sender: Any) {
        
        buttonHideShowPassword.isSelected = !buttonHideShowPassword.isSelected
        textFieldPassword.isSecureTextEntry = !buttonHideShowPassword.isSelected
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionLogin(_ sender: Any) {
        if let email = textFieldEmail.text, let password = textFieldPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self]authResult, error in
                if let error = error {
                    print(error)
                    let alert = UIAlertController(title: "error", message: "\(error.localizedDescription))", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                    self?.textFieldEmail.text = ""
                    self?.textFieldPassword.text = ""
                } else {
                    
                    if let userId = Auth.auth().currentUser?.uid {
                        self?.getUserData(userId: userId)
                    }
                }
            }
        }
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionForgotPassword(_ sender: Any) {
        
        print(#function)
        dismiss(animated: true)
    }
    
    //-------------------------------------------------------------------------------------------------------------------------------------------
    @IBAction func actionSignUp(_ sender: Any) {
        
        let signupVC : SignupVC = SignupVC(nibName :"SignupVC",bundle : nil)
        self.navigationController?.pushViewController(signupVC, animated: true)
        
        dismiss(animated: true)
    }
}
