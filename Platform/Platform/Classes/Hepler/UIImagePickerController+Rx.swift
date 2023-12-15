import UIKit
import RxSwift
import RxCocoa

// swiftlint: disable all
typealias RxImagePickerDelegateProxyType = DelegateProxy<
    UIImagePickerController,
    ImagePickerDelegate>
typealias ImagePickerDelegate = UINavigationControllerDelegate & UIImagePickerControllerDelegate
class RxImagePickerDelegateProxy:
    RxImagePickerDelegateProxyType,
    RxCocoa.DelegateProxyType,
    (UINavigationControllerDelegate & UIImagePickerControllerDelegate) {
    
    static func currentDelegate(for object: UIImagePickerController)
    -> (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? {
        return object.delegate
    }
    
    static func setCurrentDelegate(
        _ delegate: ImagePickerDelegate?,
        to object: UIImagePickerController) {
            object.delegate = delegate
        }
    
    init(imagePicker: UIImagePickerController) {
        super.init(parentObject: imagePicker,
                   delegateProxy: RxImagePickerDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { RxImagePickerDelegateProxy(imagePicker: $0) }
    }
    
}

extension Reactive where Base: UIImagePickerController {
    var imagePickerDelegate: RxImagePickerDelegateProxy {
        return RxImagePickerDelegateProxy.proxy(for: base)
    }
    /**
     
     Reactive wrapper for `delegate` message.
     */
    public var didFinishPickingMediaWithInfo: Observable<[UIImagePickerController.InfoKey: AnyObject]> {
        return imagePickerDelegate
            .methodInvoked(
                #selector(UIImagePickerControllerDelegate
                    .imagePickerController(_:didFinishPickingMediaWithInfo:)))
            .map({ (a) in
                return try Self.castOrThrow(
                    [UIImagePickerController.InfoKey: AnyObject].self,
                    a[1])
            })
    }

    /**
     Reactive wrapper for `delegate` message.
     */
    public var didCancel: Observable<()> {
        return imagePickerDelegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate
                .imagePickerControllerDidCancel(_:)))
            .map {_ in () }
    }
    
    static private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
        guard let returnValue = object as? T else {
            throw RxCocoaError.castingError(object: object, targetType: resultType)
        }

        return returnValue
    }
}
