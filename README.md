# ZRChat

![](http://img.shields.io/badge/Swift-4-orange.svg)
![Version](https://img.shields.io/cocoapods/v/ZRChatBar.svg?style=flat)	
![License](https://img.shields.io/cocoapods/l/ZRChatBar.svg?style=flat)	
![Platform](https://img.shields.io/cocoapods/p/ZRChatBar.svg?style=flat)

# Demonstration
<img src="https://github.com/mohsinalimat/ZRChat/blob/master/Jietu20180124-104214.gif" width="237" height="420">


# Installation

### Podfile

Add a PieceStore dependency to the podfile
```swift
pod 'ZRChatBar'
```

## Globalization:

| Internationalization Field      |     Format|   Description |
| :------- 	| :------ | :------|
| `"Slide your finger to cancel the recording"` |  String 	|  Prompt when recording |
| `"Release your finger, cancel sending"` |  String 	|  Prompt when recording |
| `"Hold and talk` |  String 	|  Prompt when recording |
| `"Send"` |  String 	|  Emoticon interface send button |

## Image resource provided:

> If you don't have a matching UI, you can use the matching resources in Demo.

| Image Name      |   Description |
| :------- 	| :------|
| `"zr_delete""` |  Delete button in the emoticon module |
| `"zr_emotion"` |   Expression image on chat bar |
| `"zr_keyboard"` | Keyboard picture on chat bar |
| `"zr_more"` |  More images on chat bar |
| `"zr_record_cancel"` |  Picture when the recording is cancelled |
| `"zr_recording"` |  Picture while recording |
| `"zr_voice"` |  Voice picture on chat bar |
| `"zr_signal01"` |  Sound size 01 |
| `"zr_signal02"` |  Sound size 02 |
| `"zr_signal03"` |  Sound size 03 |
| `"zr_signal04"` |  Sound size 04 |
| `"zr_signal05"` |  Sound size 05 |
| `"zr_signal06"` |  Sound size 06 |
| `"zr_signal07"` |  Sound size 07 |
| `"zr_signal08"` |  Sound size 08 |


## Use

> See also Demo

```swift

	// Custom More module
    func contentForMore() -> [ZRMoreModel] {
        let model1 = ZRMoreModel(imageStr: "chatBar_colorMore_photo", title: "Photo")
        let model2 = ZRMoreModel(imageStr: "chatBar_colorMore_camera", title: "Shooting")
        return [model1, model2]
    }
    
    // Custom emoticon module
    func contentForEmojis() -> [ZREmojisModel] {
        let models = emojis.map { (arg) -> ZREmojisModel in
            let (title, imgStr) = arg
            return ZREmojisModel(imageName: imgStr, text: title, type: .normal)
        }
        return models
    }
```


