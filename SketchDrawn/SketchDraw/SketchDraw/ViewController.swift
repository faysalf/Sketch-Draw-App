//
//  ViewController.swift
//  SketchDraw
//
//  Created by Md. Faysal Ahmed on 28/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var canvasView: CanvasView!
    
    var items: [UIColor] = [ #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.1292954087, green: 0.04908708483, blue: 0.5990313292, alpha: 1), #colorLiteral(red: 0.6280214787, green: 0, blue: 0.5465760827, alpha: 1), #colorLiteral(red: 0, green: 0.5852531195, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.5352839231, blue: 0.5120356083, alpha: 1), #colorLiteral(red: 0.5745699406, green: 0.002229140839, blue: 0, alpha: 1), #colorLiteral(red: 0.3716196716, green: 0.4066520333, blue: 0.5357112885, alpha: 1), #colorLiteral(red: 0.7282735705, green: 0.7094088197, blue: 0, alpha: 1), #colorLiteral(red: 0.7581916451, green: 0.5256002545, blue: 0.7372977734, alpha: 1), #colorLiteral(red: 0.3721770644, green: 0.7334336638, blue: 0.702003777, alpha: 1), #colorLiteral(red: 0.2638270259, green: 0.2309956253, blue: 0.1985767484, alpha: 1), #colorLiteral(red: 0.9559826255, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1) ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    @IBAction func download(_ sender: UIButton) {
        let image = canvasView.saveImageToGallery()
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saved), nil)
    }
    
    @objc func saved(_ img: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        
        if error != nil {
            alert(title: "Error!", massage: "Sorry! This image is not saved.", bTitle: "Cancel")
        }else {
            alert(title: "Saved!", massage: "Image saved Successfully.", bTitle: "Ok")
        }
    }
    
    
    func alert(title: String, massage: String, bTitle: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: bTitle, style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    
    @IBAction func brush(_ sender: UIButton) {
        canvasView.clearCanvasValue()
    }
    
    
    @IBAction func undo(_ sender: UIButton) {
        canvasView.undoCanvasValue()
    }
    
    
    @IBAction func onclickBasSize(_ sender: UISlider) {
        canvasView.strokeWidth = CGFloat(sender.value)
    }
    
    
    @IBAction func onclickBarOpacity(_ sender: UISlider) {
        canvasView.strokeOpacity = CGFloat(sender.value)
    }
    
    

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.viewWithTag(16)!.backgroundColor = items[indexPath.row]

        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        canvasView.strokeColor = items[indexPath.row]
    }
    
}
