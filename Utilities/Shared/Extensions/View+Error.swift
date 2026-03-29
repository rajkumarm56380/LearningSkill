//
//  View+Error.swift
//  DemoOffLineDBApp
//
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
