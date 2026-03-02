//
//  CombineViewModels.swift
//  DemoCombine
//
//  Created by Apple on 25/02/26.
//

import Foundation
import Combine

class CombineViewModels: ObservableObject {

    //Receives values from a publisher.

    func samplePublisher() {
        let publisher = Just("Hello")
        publisher.sink { value in
            print("Result ==>",value)
        }
    }

}
