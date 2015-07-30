
import UIKit

public class PlaceholderTextView: UITextView {
    
    private lazy var placeholderLabel:UILabel = UILabel()
    public var placeholderColor:UIColor  = UIColor.lightGrayColor()
    public var placeholder = ""

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChanged:", name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    override public func drawRect(rect: CGRect) {
        if !self.placeholder.isEmpty {
            self.placeholderLabel.frame           = CGRectMake(8,8,self.bounds.size.width - 16,0)
            self.placeholderLabel.lineBreakMode   = NSLineBreakMode.ByWordWrapping
            self.placeholderLabel.numberOfLines   = 0
            self.placeholderLabel.font            = self.font
            self.placeholderLabel.backgroundColor = UIColor.clearColor()
            self.placeholderLabel.textColor       = self.placeholderColor
            self.placeholderLabel.alpha           = 0
            self.placeholderLabel.tag             = 999
            
            self.placeholderLabel.text = self.placeholder
            self.placeholderLabel.sizeToFit()
            self.addSubview(placeholderLabel)
        }
        
        self.sendSubviewToBack(placeholderLabel)
        
        if self.text.isEmpty && !self.placeholder.isEmpty {
            self.viewWithTag(999)?.alpha = 1
        }
        
        super.drawRect(rect)
    }
    
    public func textChanged(notification:NSNotification?) {
        if self.placeholder.isEmpty {
            return
        }
        
        if self.text.isEmpty {
            self.viewWithTag(999)?.alpha = 1
        } else {
            self.viewWithTag(999)?.alpha = 0
        }
    }
    
}
