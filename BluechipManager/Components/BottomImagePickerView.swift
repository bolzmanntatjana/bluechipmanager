//
//  BottomImagePickerView.swift
//  BluechipManager
//
//  Created by admin on 6/25/24.
//




import SwiftUI

struct BottomImagePickerView: View {
    
    @State private var isCameraShown = false
    @State private var isPickerShown = false
    
    @Binding var image: UIImage?
    
    var completion: () -> ()
    var closing: () -> ()
    
    var body: some View {
        ZStack {
           VStack {
               ZStack {
                   Rectangle()
                       .foregroundColor(.darkBlue)
                       .ignoresSafeArea()
                   VStack {
                       HStack {
                           Button {
                               isCameraShown.toggle()
                           } label: {
                               Rectangle()
                                   .foregroundColor(.lightBlue.opacity(0.5))
                                   .frame(width: 100, height: 100)
                                   .cornerRadius(12)
                                   .overlay {
                                       VStack {
                                           Image(systemName: "camera")
                                               .resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 30, height: 30)
                                               .padding(.bottom, 10)
                                           Text("Camera")
                                       }
                                       .foregroundColor(.white)
                                   }
                           }
                           
                           Button {
                               isPickerShown.toggle()
                           } label: {
                               Rectangle()
                                   .foregroundColor(.lightBlue.opacity(0.5))
                                   .frame(width: 100, height: 100)
                                   .cornerRadius(12)
                                   .overlay {
                                       VStack {
                                           Image(systemName: "photo.on.rectangle.angled")
                                               .resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 30, height: 30)
                                               .padding(.bottom, 10)
                                           Text("Library")
                                       }
                                       .foregroundColor(.white)
                                   }
                           }
                       }
                       .tint(.white)
                       
                       Spacer()
                   }
                   .padding(.top, 50)
                   
               }
           }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isCameraShown) {
            PhotoPicker(source: .camera, photo: $image)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $isPickerShown) {
            PhotoPicker(source: .photoLibrary, photo: $image)
                .onDisappear {
                    if let _ = image {
                        completion()
                    }
                }
                .ignoresSafeArea()
        }
    }
}

#Preview {
    BottomImagePickerView(image: .constant(UIImage(named: "logo"))) {
        
    } closing: {
        
    }

}


struct PhotoPicker: UIViewControllerRepresentable {
    
    var source: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var photo: UIImage?
    
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = source
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: PhotoPicker
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.photo = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
