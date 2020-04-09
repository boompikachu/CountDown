//
//  UnsplashPickerView.swift
//  CountDown
//
//  Created by Patthanat Thanintantrakun on 8/4/20.
//  Copyright © 2020 Patthanat Thanintantrakun. All rights reserved.
//

import SwiftUI
import UnsplashPhotoPicker
import Combine

struct UnsplashPickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    
    let unsplashConfig = UnsplashPhotoPickerConfiguration(accessKey: "fCV4shiwknVcf1fBIbWcMyrdq9fqcwXUyVbVn9ypK0I", secretKey: "jom9b--cLrD6A1XfVJal06vtvs-nHqpSn2iW9jWbezs")
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UnsplashPhotoPickerDelegate {
        let parent: UnsplashPickerView
        var imageDataTask: URLSessionDataTask?

        init(_ parent: UnsplashPickerView) {
            self.parent = parent
        }
        
        func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
            
            print("Selected Photo")
            
            
            guard let url = photos.first?.urls[.regular] else { return }


            imageDataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
                guard let strongSelf = self else { return }

                strongSelf.imageDataTask = nil

                guard let data = data, let image = UIImage(data: data), error == nil else { return }

                DispatchQueue.main.async {
                    
                    print("Sucessfully get image")
                    self?.parent.image = image
                }
            }

            imageDataTask?.resume()
            
            
            
            
            
            
            
        }
        
        func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
            print("Cancel")
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<UnsplashPickerView>) -> UINavigationController {
        
        let unsplash = UnsplashPhotoPicker(configuration: unsplashConfig)
        unsplash.photoPickerDelegate = context.coordinator
        return unsplash
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<UnsplashPickerView>) {

    }
}

struct UnsplashPickerView_Previews: PreviewProvider {
    static var previews: some View {
        UnsplashPickerView(image: Binding.constant(nil))
    }
}
