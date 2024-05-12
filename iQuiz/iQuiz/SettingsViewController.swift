//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/8.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var changeUrlField: UITextField!
    @IBOutlet weak var changeUrlBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        let dict : [String: Any] = ["key1": "value1", "key2": 2, "key3": true]
        saveJSONDictionaryToUserDefaults(jsonDictionary: dict, forKey: "myJsonDictionary")
        print(UserDefaults.standard.dictionaryRepresentation())
        if let retrievedDictionary = retrieveJSONDictionaryFromUserDefaults(forKey: "myJsonDictionary") {
            print("Retrieved Dictionary: \(retrievedDictionary)")
        } else {
            print("No dictionary found for the given key")
        }
    }
    
    func saveJSONDictionaryToUserDefaults(jsonDictionary: [String: Any], forKey key: String) {
        // Convert the dictionary to property list types
        let serializedData: Data
        do {
            serializedData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }

        // Get the shared UserDefaults instance
        let defaults = UserDefaults.standard

        // Store the serialized data
        defaults.set(serializedData, forKey: key)
    }
    
    func retrieveJSONDictionaryFromUserDefaults(forKey key: String) -> [String: Any]? {
        // Get the shared UserDefaults instance
        let defaults = UserDefaults.standard

        // Retrieve the serialized data
        guard let retrievedData = defaults.data(forKey: key) else {
            return nil
        }

        // Deserialize the data back into a dictionary
        guard let retrievedDictionary = try? JSONSerialization.jsonObject(with: retrievedData, options: []) as? [String: Any] else {
            return nil
        }
        return retrievedDictionary
    }
    
    @IBAction func changeUrl(_ sender: Any) {
        let newUrl : String = changeUrlField.text ?? ""
        if newUrl == "" {
            let alertController = UIAlertController(title: "Error", message: "Please type in the new URL in the text box", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            print("change URL to \(newUrl)")
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
