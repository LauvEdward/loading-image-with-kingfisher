//
//  ImagesViewModel.swift
//  ApplicationTryTechnical
//
//  Created by Edward Lauv on 1/26/21.
//

import Foundation
class ImagesViewModel : NSObject{
    private var apiServiceImage : APIServiceImage!
    var empData : [Image]! {
        didSet {
            self.bindImageViewModelToController()
        }
    }
    var bindImageViewModelToController : (() -> ()) = {}
    override init() {
        super.init()
        apiServiceImage = APIServiceImage()
        callFunctoGetEmpData()
    }
    
    func callFunctoGetEmpData() {
        self.apiServiceImage.fetchImageAlamorefire { (listimage) in
            self.empData = listimage
        }
    }
    
    
}
