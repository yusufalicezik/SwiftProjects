//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
 
    
    
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        self.view = view
        let logoLabel = setupLogoLabel()
        let eMailTxt = setupTextField(1)
        let passWordTxt = setupTextField(2)
        let loginButton = setupLoginButton()
        self.view.addSubview(loginButton)
        self.view.addSubview(logoLabel)
        self.view.addSubview(eMailTxt)
        self.view.addSubview(passWordTxt)
       
        
        
        //Constraints
        
        
            //Logo
        logoLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        logoLabel.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-10).isActive = true
        logoLabel.topAnchor.constraint(equalTo:self.view.topAnchor, constant:20).isActive = true
        
        
        
            //Email
            eMailTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            eMailTxt.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
            eMailTxt.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20).isActive = true
        
        
         eMailTxt.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        
            //password
            passWordTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            passWordTxt.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
            passWordTxt.topAnchor.constraint(equalTo: eMailTxt.bottomAnchor, constant: 20).isActive = true
        
        
            passWordTxt.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        
        //Button
        loginButton.leftAnchor.constraint(equalTo:view.leftAnchor, constant:40).isActive = true
        loginButton.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-40).isActive = true
        loginButton.topAnchor.constraint(equalTo:passWordTxt.bottomAnchor, constant:60).isActive = true
        
        



        
    }
    func setupLoginButton()->UIButton{
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.setTitle("Kayıt Olmak İçin Tıkla", for: UIControl.State.normal)
        button.frame = CGRect(x: 30, y: 30, width: 200, height: 50)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.tintColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    func setupLogoLabel()->UILabel{
        let label = UILabel()
        label.text = "Wodoo"
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 85.0, weight: UIFont.Weight.medium)
        label.frame = CGRect(x: 10, y: 10, width: 150, height: 120)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setupTextField(_ id:Int)->UITextField{
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
            txtField.backgroundColor = .clear
        txtField.layer.cornerRadius = 10
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        txtField.frame = CGRect(x: 10, y: 10, width: 150, height: 120)
        
        if id == 1{
            //Email
            txtField.placeholder = "E-Mail"
        }else{
            //password
            txtField.placeholder = "Password"
        }
        return txtField
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
