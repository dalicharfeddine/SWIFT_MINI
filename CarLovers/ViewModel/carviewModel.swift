import Foundation
import Alamofire


class carviewModel: ObservableObject {
    @Published var marque: String = ""
    @Published var model: String = ""
    @Published var description: String = ""
    @Published var imageData: Data?
    private let userToken: String? = UserDefaults.standard.string(forKey: "accessToken")
    func addCar(image: UIImage, completion: @escaping () -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert UIImage to Data")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")",
            "Content-type": "multipart/form-data"
        ]

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            multipartFormData.append(self.marque.data(using: .utf8)!, withName: "marque")
            multipartFormData.append(self.model.data(using: .utf8)!, withName: "model")
            multipartFormData.append(self.description.data(using: .utf8)!, withName: "description")
            print(self.imageData)
        }, to: "http://172.17.1.23:9091/car", method: .post, headers: headers)
        .validate()
        .responseDecodable(of: AddcarResponse.self) { response in
            switch response.result {
            case .success(let addCarResponse):
                print(addCarResponse.status)
                print(addCarResponse.message)
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    
}




