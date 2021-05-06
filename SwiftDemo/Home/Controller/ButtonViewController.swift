//
//  ButtonViewController.swift
//  SwiftDemo
//
//  Created by hanghang on 2021/4/8.
//

import UIKit
import SwiftyRSA
import CryptoSwift
class ButtonViewController: UIViewController {

    @IBOutlet weak var encryptL: UILabel!
    @IBOutlet weak var decryptL: UILabel!
    var pubStr:String = ""
    
    
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
       
    }


   func setupUI(){
    navigationItem.title = "RSA"
    view.backgroundColor = .white
    }

    //MARK: - action
    
    @IBAction func encryptAction(_ sender: UIButton) {

        let str = rsa_encrypt("123")
        encryptL.text = str
    }
    
    @IBAction func decryptAction(_ sender: UIButton) {
        let str = rsa_decrypt( encryptL.text!)
        decryptL.text = str
    }
    
    
    //MARK: - private
     func rsa_encrypt(_ str:String) -> String{
            var reslutStr = ""
            do{
                let path = Bundle.main.path(forResource: "rsa_public_key", ofType: "pem")!
                let pemString = try String(contentsOfFile: path)
                let rsa_publicKey = try PublicKey(pemEncoded: pemString)
                let clear = try ClearMessage(string: str, using: .utf8)
                reslutStr = try clear.encrypted(with: rsa_publicKey, padding:.OAEP).base64String

            }catch{
                print("RSA加密失败")
            }
            return reslutStr;
        }

    func rsa_decrypt(_ str:String) -> String{
        var reslutStr = ""

        do{
            let privateKey = try PrivateKey(pemNamed: "pkcs8_private_key")
            let encrypted = try EncryptedMessage(base64Encoded: str)
            let clear = try encrypted.decrypted(with: privateKey, padding: .OAEP)
            reslutStr = try clear.string(encoding: .utf8)
        }catch{
            print("RSA解密失败")
        }
        return reslutStr
    }
    
    
    //MARK: - RSA
    
    func encryptMethod(_ str: String) -> String {
        let path = Bundle.main.path(forResource: "public_key", ofType:"der")!
        let pemString = try? String(contentsOfFile: path)
        pubStr = RSA.encryptString("hello world", publicKey: pemString)
        return pubStr
    }
    
    func decryptMethod(_ str: String) -> String {
        let path = Bundle.main.path(forResource: "private_key", ofType: "p12")!
        let pemString = try? String(contentsOfFile: path)
        let str =  RSA.decryptString(pubStr, privateKey: pemString)
        return str!
    }
}
