//
//  SignInViewController.swift
//  MusicCalmMac
//
//  Created by Nithya Appannagaari on 12/25/22.
//

import UIKit

//var usernames = [] as NSMutableArray
//var passwords = [] as NSMutableArray

class SignInViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccount(_ sender: Any) {
        var name = username.text!
        var pass = password.text!
        writeFile(file: "Accounts", stringData: name)
        writeFile(file: "Passwords", stringData: pass)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarID") as? TabBarViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // create function to write to file
    func writeFile(file: String, stringData: String) {
        
        // get the fileURL
        let toWrite = "\n" + stringData
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(file)

        if let handle = try? FileHandle(forWritingTo: path){
            handle.seekToEndOfFile()
            handle.write(toWrite.data(using: .utf8)!)
            handle.closeFile()
        }
        
        do{
            let fileData = try Data(contentsOf: path)
            let stringFromData = String(data: fileData, encoding: .utf8)
            
            print(stringFromData)
        }
        catch {
            print("error")
        }
    }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

