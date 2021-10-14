//
//  ViewController.swift
//  CustomSegmentControl_Tutorial
//
//  Created by SeongMinK on 2021/10/14.
//

import UIKit

class ViewController: UIViewController, MyCustomSegmentControlDelegate {
    
    var myDayArray = ["월", "화", "수", "목", "금"]
    let myDayCharacterArray = ["🐶","🐱","🐭", "🐹", "🦊"]
    
    @IBOutlet weak var whatDayTitle: UILabel!
    
    func segmentValueChanged(to index: Int) {
        print(#fileID, #function, "called / index: \(index)")
        self.whatDayTitle.text = myDayArray[index] + "요일\n" + myDayCharacterArray[index]
    }

    override func loadView() {
        super.loadView()
        print(#fileID, #function, "called")
        
        let myCustomSegmentControl = MyCustomSegmentControl(frame: CGRect(x: 0, y: 0, width: 200, height: 200), buttonTitles: myDayArray)
        
        myCustomSegmentControl.mySegmentDelegate = self
        
        self.view.addSubview(myCustomSegmentControl)
        myCustomSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        myCustomSegmentControl.widthAnchor.constraint(equalToConstant: 300).isActive = true
        myCustomSegmentControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        myCustomSegmentControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        myCustomSegmentControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#fileID, #function, "called")
    }
}
