//
//  View+Error.swift
//  DemoOffLineDBApp
//
//  Created by Apple on 25/03/26.
//

import SwiftUI

extension View {
    func errorOverlay(
        error: String?,
        retryAction: (() -> Void)? = nil
    ) -> some View {
            self.overlay {
                if let error = error {
                    ErrorOverlayView(
                        message: error,
                        retryAction: retryAction
                    )
                }
            }
    }
        // calling 
        //.errorOverlay(error: viewModel.errorMessage) {
        //            viewModel.login() // retry
        //        }
}
