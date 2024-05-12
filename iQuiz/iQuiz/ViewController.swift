//
//  ViewController.swift
//  iQuiz
//
//  Created by Ricwxiao on 2024/5/1.
//

import Foundation
import UIKit

class QuizSelectionCell: UITableViewCell {
    @IBOutlet weak var quizIcon: UIImageView!
    @IBOutlet weak var quizSubject: UILabel!
    @IBOutlet weak var quizDescription: UILabel!
    @IBOutlet weak var goButton: UIButton!
}

struct Quiz {
    let subject: String
    let desc: String
    let icon: String?
}

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var quizTable: UITableView!
    
    let quizTableData = QuizTableDataModel(quizList: [
        Quiz(subject: "Mathematics", desc: "Math questions.", icon: "math.png"),
        Quiz(subject: "Marvel Super Heroes", desc: "Marvel Super Hero related questions.", icon: "hero.png"),
        Quiz(subject: "Science", desc: "Questions on science, mainly physics and chemistry.", icon: "science.png")
    ]
    )
    
    class QuizTableDataModel : NSObject,UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate {
        var quizList : [Quiz]
        
        init(quizList: [Quiz]) {
            self.quizList = quizList
        }
        
        func getQuizList() -> [Quiz] {
            return self.quizList
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return quizList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let id = indexPath.row
            let quiz = quizList[id]
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizSelectionCell")! as! QuizSelectionCell
            if quiz.icon == nil {
                cell.quizIcon.image = UIImage(named:"default-icon")
            } else {
                cell.quizIcon.image = UIImage(named: quiz.icon!)
            }
            cell.quizSubject.text = quiz.subject
            cell.quizDescription.text = quiz.desc
//            cell.goButton.tag = id
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quizTable.dataSource = quizTableData
        quizTable.delegate = self
    }
    
    // MARK: This was used to pop up the alert window
//    @IBAction func openSettings(_ sender: Any) {
//        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
    
    @IBAction func goToQuiz(_ sender: UIButton) {
        performSegue(withIdentifier: "goToQuizSegue", sender: sender)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToQuizSegue" {
//            if let btn = sender as? UIButton{
//                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                let didSetTopicId = appDelegate.setTopicId(btn.tag)
//                    if didSetTopicId {
//                        print("Topic ID set successfully.")
//                    } else {
//                        print("Failed to set Topic ID.")
//                    }
//                }
//            }
//        }
//    }
}
