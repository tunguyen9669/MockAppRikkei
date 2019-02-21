//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `NOTICE.txt`.
    static let noticeTxt = Rswift.FileResource(bundle: R.hostingBundle, name: "NOTICE", pathExtension: "txt")
    /// Resource file `Roboto_Specimen_Book.pdf`.
    static let roboto_Specimen_BookPdf = Rswift.FileResource(bundle: R.hostingBundle, name: "Roboto_Specimen_Book", pathExtension: "pdf")
    
    /// `bundle.url(forResource: "NOTICE", withExtension: "txt")`
    static func noticeTxt(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.noticeTxt
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "Roboto_Specimen_Book", withExtension: "pdf")`
    static func roboto_Specimen_BookPdf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.roboto_Specimen_BookPdf
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 16 fonts.
  struct font: Rswift.Validatable {
    /// Font `Roboto-BlackItalic`.
    static let robotoBlackItalic = Rswift.FontResource(fontName: "Roboto-BlackItalic")
    /// Font `Roboto-Black`.
    static let robotoBlack = Rswift.FontResource(fontName: "Roboto-Black")
    /// Font `Roboto-BoldCondensedItalic`.
    static let robotoBoldCondensedItalic = Rswift.FontResource(fontName: "Roboto-BoldCondensedItalic")
    /// Font `Roboto-BoldCondensed`.
    static let robotoBoldCondensed = Rswift.FontResource(fontName: "Roboto-BoldCondensed")
    /// Font `Roboto-BoldItalic`.
    static let robotoBoldItalic = Rswift.FontResource(fontName: "Roboto-BoldItalic")
    /// Font `Roboto-Bold`.
    static let robotoBold = Rswift.FontResource(fontName: "Roboto-Bold")
    /// Font `Roboto-CondensedItalic`.
    static let robotoCondensedItalic = Rswift.FontResource(fontName: "Roboto-CondensedItalic")
    /// Font `Roboto-Condensed`.
    static let robotoCondensed = Rswift.FontResource(fontName: "Roboto-Condensed")
    /// Font `Roboto-Italic`.
    static let robotoItalic = Rswift.FontResource(fontName: "Roboto-Italic")
    /// Font `Roboto-LightItalic`.
    static let robotoLightItalic = Rswift.FontResource(fontName: "Roboto-LightItalic")
    /// Font `Roboto-Light`.
    static let robotoLight = Rswift.FontResource(fontName: "Roboto-Light")
    /// Font `Roboto-MediumItalic`.
    static let robotoMediumItalic = Rswift.FontResource(fontName: "Roboto-MediumItalic")
    /// Font `Roboto-Medium`.
    static let robotoMedium = Rswift.FontResource(fontName: "Roboto-Medium")
    /// Font `Roboto-Regular`.
    static let robotoRegular = Rswift.FontResource(fontName: "Roboto-Regular")
    /// Font `Roboto-ThinItalic`.
    static let robotoThinItalic = Rswift.FontResource(fontName: "Roboto-ThinItalic")
    /// Font `Roboto-Thin`.
    static let robotoThin = Rswift.FontResource(fontName: "Roboto-Thin")
    
    /// `UIFont(name: "Roboto-Black", size: ...)`
    static func robotoBlack(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBlack, size: size)
    }
    
    /// `UIFont(name: "Roboto-BlackItalic", size: ...)`
    static func robotoBlackItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBlackItalic, size: size)
    }
    
    /// `UIFont(name: "Roboto-Bold", size: ...)`
    static func robotoBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBold, size: size)
    }
    
    /// `UIFont(name: "Roboto-BoldCondensed", size: ...)`
    static func robotoBoldCondensed(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBoldCondensed, size: size)
    }
    
    /// `UIFont(name: "Roboto-BoldCondensedItalic", size: ...)`
    static func robotoBoldCondensedItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBoldCondensedItalic, size: size)
    }
    
    /// `UIFont(name: "Roboto-BoldItalic", size: ...)`
    static func robotoBoldItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoBoldItalic, size: size)
    }
    
    /// `UIFont(name: "Roboto-Condensed", size: ...)`
    static func robotoCondensed(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoCondensed, size: size)
    }
    
    /// `UIFont(name: "Roboto-CondensedItalic", size: ...)`
    static func robotoCondensedItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoCondensedItalic, size: size)
    }
    
    /// `UIFont(name: "Roboto-Italic", size: ...)`
    static func robotoItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoItalic, size: size)
    }
    
    /// `UIFont(name: "Roboto-Light", size: ...)`
    static func robotoLight(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoLight, size: size)
    }
    
    /// `UIFont(name: "Roboto-LightItalic", size: ...)`
    static func robotoLightItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoLightItalic, size: size)
    }
    
    /// `UIFont(name: "Roboto-Medium", size: ...)`
    static func robotoMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoMedium, size: size)
    }
    
    /// `UIFont(name: "Roboto-MediumItalic", size: ...)`
    static func robotoMediumItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoMediumItalic, size: size)
    }
    
    /// `UIFont(name: "Roboto-Regular", size: ...)`
    static func robotoRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoRegular, size: size)
    }
    
    /// `UIFont(name: "Roboto-Thin", size: ...)`
    static func robotoThin(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoThin, size: size)
    }
    
    /// `UIFont(name: "Roboto-ThinItalic", size: ...)`
    static func robotoThinItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: robotoThinItalic, size: size)
    }
    
    static func validate() throws {
      if R.font.robotoBlack(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Black' could not be loaded, is 'Roboto-Black.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoBlackItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-BlackItalic' could not be loaded, is 'Roboto-BlackItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Bold' could not be loaded, is 'Roboto-Bold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoBoldCondensed(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-BoldCondensed' could not be loaded, is 'Roboto-BoldCondensed.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoBoldCondensedItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-BoldCondensedItalic' could not be loaded, is 'Roboto-BoldCondensedItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoBoldItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-BoldItalic' could not be loaded, is 'Roboto-BoldItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoCondensed(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Condensed' could not be loaded, is 'Roboto-Condensed.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoCondensedItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-CondensedItalic' could not be loaded, is 'Roboto-CondensedItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Italic' could not be loaded, is 'Roboto-Italic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoLight(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Light' could not be loaded, is 'Roboto-Light.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoLightItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-LightItalic' could not be loaded, is 'Roboto-LightItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Medium' could not be loaded, is 'Roboto-Medium.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoMediumItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-MediumItalic' could not be loaded, is 'Roboto-MediumItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Regular' could not be loaded, is 'Roboto-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoThin(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-Thin' could not be loaded, is 'Roboto-Thin.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.robotoThinItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Roboto-ThinItalic' could not be loaded, is 'Roboto-ThinItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 13 images.
  struct image {
    /// Image `back`.
    static let back = Rswift.ImageResource(bundle: R.hostingBundle, name: "back")
    /// Image `browse_selected`.
    static let browse_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "browse_selected")
    /// Image `browse`.
    static let browse = Rswift.ImageResource(bundle: R.hostingBundle, name: "browse")
    /// Image `default_image`.
    static let default_image = Rswift.ImageResource(bundle: R.hostingBundle, name: "default_image")
    /// Image `home_selected`.
    static let home_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "home_selected")
    /// Image `home`.
    static let home = Rswift.ImageResource(bundle: R.hostingBundle, name: "home")
    /// Image `near_selected`.
    static let near_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "near_selected")
    /// Image `near`.
    static let near = Rswift.ImageResource(bundle: R.hostingBundle, name: "near")
    /// Image `red_star`.
    static let red_star = Rswift.ImageResource(bundle: R.hostingBundle, name: "red_star")
    /// Image `rikkeisoft-logo`.
    static let rikkeisoftLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "rikkeisoft-logo")
    /// Image `user_selected`.
    static let user_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "user_selected")
    /// Image `user`.
    static let user = Rswift.ImageResource(bundle: R.hostingBundle, name: "user")
    /// Image `yellow_star`.
    static let yellow_star = Rswift.ImageResource(bundle: R.hostingBundle, name: "yellow_star")
    
    /// `UIImage(named: "back", bundle: ..., traitCollection: ...)`
    static func back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.back, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "browse", bundle: ..., traitCollection: ...)`
    static func browse(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.browse, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "browse_selected", bundle: ..., traitCollection: ...)`
    static func browse_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.browse_selected, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "default_image", bundle: ..., traitCollection: ...)`
    static func default_image(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.default_image, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "home", bundle: ..., traitCollection: ...)`
    static func home(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "home_selected", bundle: ..., traitCollection: ...)`
    static func home_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home_selected, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "near", bundle: ..., traitCollection: ...)`
    static func near(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.near, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "near_selected", bundle: ..., traitCollection: ...)`
    static func near_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.near_selected, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "red_star", bundle: ..., traitCollection: ...)`
    static func red_star(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.red_star, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "rikkeisoft-logo", bundle: ..., traitCollection: ...)`
    static func rikkeisoftLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.rikkeisoftLogo, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "user", bundle: ..., traitCollection: ...)`
    static func user(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.user, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "user_selected", bundle: ..., traitCollection: ...)`
    static func user_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.user_selected, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "yellow_star", bundle: ..., traitCollection: ...)`
    static func yellow_star(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.yellow_star, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `NewsCell`.
    static let newsCell = _R.nib._NewsCell()
    /// Nib `PopularCell`.
    static let popularCell = _R.nib._PopularCell()
    
    /// `UINib(name: "NewsCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.newsCell) instead")
    static func newsCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.newsCell)
    }
    
    /// `UINib(name: "PopularCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.popularCell) instead")
    static func popularCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.popularCell)
    }
    
    static func newsCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsCell? {
      return R.nib.newsCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsCell
    }
    
    static func popularCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> PopularCell? {
      return R.nib.popularCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? PopularCell
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `PopularCell`.
    static let popularCell: Rswift.ReuseIdentifier<PopularCell> = Rswift.ReuseIdentifier(identifier: "PopularCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 2 view controllers.
  struct segue {
    /// This struct is generated for `HomeViewController`, and contains static references to 2 segues.
    struct homeViewController {
      /// Segue identifier `news`.
      static let news: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, HomeViewController, NewsViewController> = Rswift.StoryboardSegueIdentifier(identifier: "news")
      /// Segue identifier `popular`.
      static let popular: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, HomeViewController, PopularViewController> = Rswift.StoryboardSegueIdentifier(identifier: "popular")
      
      /// Optionally returns a typed version of segue `news`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func news(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, HomeViewController, NewsViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.homeViewController.news, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `popular`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func popular(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, HomeViewController, PopularViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.homeViewController.popular, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `MyListEventViewController`, and contains static references to 2 segues.
    struct myListEventViewController {
      /// Segue identifier `going`.
      static let going: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MyListEventViewController, GoingViewController> = Rswift.StoryboardSegueIdentifier(identifier: "going")
      /// Segue identifier `went`.
      static let went: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MyListEventViewController, WentViewController> = Rswift.StoryboardSegueIdentifier(identifier: "went")
      
      /// Optionally returns a typed version of segue `going`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func going(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MyListEventViewController, GoingViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.myListEventViewController.going, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `went`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func went(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MyListEventViewController, WentViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.myListEventViewController.went, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 6 storyboards.
  struct storyboard {
    /// Storyboard `Browse`.
    static let browse = _R.storyboard.browse()
    /// Storyboard `Home`.
    static let home = _R.storyboard.home()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    /// Storyboard `MyPage`.
    static let myPage = _R.storyboard.myPage()
    /// Storyboard `Near`.
    static let near = _R.storyboard.near()
    
    /// `UIStoryboard(name: "Browse", bundle: ...)`
    static func browse(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.browse)
    }
    
    /// `UIStoryboard(name: "Home", bundle: ...)`
    static func home(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.home)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    /// `UIStoryboard(name: "MyPage", bundle: ...)`
    static func myPage(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.myPage)
    }
    
    /// `UIStoryboard(name: "Near", bundle: ...)`
    static func near(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.near)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
    try nib.validate()
  }
  
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _NewsCell.validate()
      try _PopularCell.validate()
    }
    
    struct _NewsCell: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "NewsCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> NewsCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? NewsCell
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "default_image", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'default_image' is used in nib 'NewsCell', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct _PopularCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = PopularCell
      
      let bundle = R.hostingBundle
      let identifier = "PopularCell"
      let name = "PopularCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> PopularCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? PopularCell
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "default_image", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'default_image' is used in nib 'PopularCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "red_star", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'red_star' is used in nib 'PopularCell', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try browse.validate()
      try home.validate()
      try launchScreen.validate()
      try main.validate()
      try myPage.validate()
      try near.validate()
    }
    
    struct browse: Rswift.StoryboardResourceType, Rswift.Validatable {
      let browseViewController = StoryboardViewControllerResource<BrowseViewController>(identifier: "BrowseViewController")
      let bundle = R.hostingBundle
      let name = "Browse"
      
      func browseViewController(_: Void = ()) -> BrowseViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: browseViewController)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.browse().browseViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'browseViewController' could not be loaded from storyboard 'Browse' as 'BrowseViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct home: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let homeViewController = StoryboardViewControllerResource<HomeViewController>(identifier: "HomeViewController")
      let name = "Home"
      let newsViewController = StoryboardViewControllerResource<NewsViewController>(identifier: "NewsViewController")
      let popularViewController = StoryboardViewControllerResource<PopularViewController>(identifier: "PopularViewController")
      
      func homeViewController(_: Void = ()) -> HomeViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: homeViewController)
      }
      
      func newsViewController(_: Void = ()) -> NewsViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newsViewController)
      }
      
      func popularViewController(_: Void = ()) -> PopularViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: popularViewController)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.home().homeViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'homeViewController' could not be loaded from storyboard 'Home' as 'HomeViewController'.") }
        if _R.storyboard.home().newsViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newsViewController' could not be loaded from storyboard 'Home' as 'NewsViewController'.") }
        if _R.storyboard.home().popularViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'popularViewController' could not be loaded from storyboard 'Home' as 'PopularViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ViewController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct myPage: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let eventDetailViewController = StoryboardViewControllerResource<EventDetailViewController>(identifier: "EventDetailViewController")
      let forgotPasswordViewController = StoryboardViewControllerResource<ForgotPasswordViewController>(identifier: "ForgotPasswordViewController")
      let goingViewController = StoryboardViewControllerResource<GoingViewController>(identifier: "GoingViewController")
      let loginViewController = StoryboardViewControllerResource<LoginViewController>(identifier: "LoginViewController")
      let myListEventViewController = StoryboardViewControllerResource<MyListEventViewController>(identifier: "MyListEventViewController")
      let myPageViewController = StoryboardViewControllerResource<MyPageViewController>(identifier: "MyPageViewController")
      let name = "MyPage"
      let registerViewController = StoryboardViewControllerResource<RegisterViewController>(identifier: "RegisterViewController")
      let wentViewController = StoryboardViewControllerResource<WentViewController>(identifier: "WentViewController")
      
      func eventDetailViewController(_: Void = ()) -> EventDetailViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: eventDetailViewController)
      }
      
      func forgotPasswordViewController(_: Void = ()) -> ForgotPasswordViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: forgotPasswordViewController)
      }
      
      func goingViewController(_: Void = ()) -> GoingViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: goingViewController)
      }
      
      func loginViewController(_: Void = ()) -> LoginViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: loginViewController)
      }
      
      func myListEventViewController(_: Void = ()) -> MyListEventViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: myListEventViewController)
      }
      
      func myPageViewController(_: Void = ()) -> MyPageViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: myPageViewController)
      }
      
      func registerViewController(_: Void = ()) -> RegisterViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: registerViewController)
      }
      
      func wentViewController(_: Void = ()) -> WentViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: wentViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "back", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'back' is used in storyboard 'MyPage', but couldn't be loaded.") }
        if UIKit.UIImage(named: "rikkeisoft-logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'rikkeisoft-logo' is used in storyboard 'MyPage', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.myPage().eventDetailViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'eventDetailViewController' could not be loaded from storyboard 'MyPage' as 'EventDetailViewController'.") }
        if _R.storyboard.myPage().forgotPasswordViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'forgotPasswordViewController' could not be loaded from storyboard 'MyPage' as 'ForgotPasswordViewController'.") }
        if _R.storyboard.myPage().goingViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'goingViewController' could not be loaded from storyboard 'MyPage' as 'GoingViewController'.") }
        if _R.storyboard.myPage().loginViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'loginViewController' could not be loaded from storyboard 'MyPage' as 'LoginViewController'.") }
        if _R.storyboard.myPage().myListEventViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'myListEventViewController' could not be loaded from storyboard 'MyPage' as 'MyListEventViewController'.") }
        if _R.storyboard.myPage().myPageViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'myPageViewController' could not be loaded from storyboard 'MyPage' as 'MyPageViewController'.") }
        if _R.storyboard.myPage().registerViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'registerViewController' could not be loaded from storyboard 'MyPage' as 'RegisterViewController'.") }
        if _R.storyboard.myPage().wentViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'wentViewController' could not be loaded from storyboard 'MyPage' as 'WentViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct near: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "Near"
      let nearViewController = StoryboardViewControllerResource<NearViewController>(identifier: "NearViewController")
      
      func nearViewController(_: Void = ()) -> NearViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: nearViewController)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.near().nearViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'nearViewController' could not be loaded from storyboard 'Near' as 'NearViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
