//
//  NotePromptViewController.swift
//  CookingScheduler
//
//  Created by Travis Chambers on 12/7/16.
//  Copyright © 2016 Andrew Wang. All rights reserved.
//

import UIKit

protocol NotePopUpDelegate {
    func dismissNote()
    func submitNote(note: String, indexPath:IndexPath)
}

class NotePromptViewController: UIViewController {

    @IBOutlet weak var noteField: UITextView!
    var delegate:NotePopUpDelegate? = nil
    var indexPath:IndexPath? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) {
        delegate?.submitNote(note:noteField.text, indexPath:self.indexPath!)
        delegate?.dismissNote()
    }

    @IBAction func cancel(_ sender: Any) {
        delegate?.dismissNote()
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        
        self.noteField.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
