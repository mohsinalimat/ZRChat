# ZRChat

![](http://img.shields.io/badge/Swift-4-orange.svg)
![Version](https://img.shields.io/cocoapods/v/ZRChatBar.svg?style=flat)	
![License](https://img.shields.io/cocoapods/l/ZRChatBar.svg?style=flat)	
![Platform](https://img.shields.io/cocoapods/p/ZRChatBar.svg?style=flat)

# 演示
<img src="https://github.com/ZeroFengLee/ZRChat/blob/master/Jietu20180124-104214.gif" width="237" height="420">


# 安装

### Podfile

在podfile中添加PieceStore依赖
```swift
pod 'ZRChatBar'
```

## 国际化:

| 国际化字段      |     格式|   说明 |
| :------- 	| :------ | :------|
| `"手指上滑, 取消录音"` |  String 	|  录音时的提示语 |
| `"松开手指, 取消发送"` |  String 	|  录音时的提示语 |
| `"按住 说话` |  String 	|  录音时的提示语 |
| `"发送"` |  String 	|  表情界面发送按钮 |

## 提供的图片资源:

> 假如自己没有配套的UI，可以使用Demo中的配套资源

| 图片名称      |   说明 |
| :------- 	| :------|
| `"zr_delete""` |  表情模块中的删除按钮 |
| `"zr_emotion"` |   chat bar上的表情图片 |
| `"zr_keyboard"` | chat bar上的键盘图片 |
| `"zr_more"` |  chat bar上的更多图片 |
| `"zr_record_cancel"` |  录音取消时的图片 |
| `"zr_recording"` |  正在录音时的图片 |
| `"zr_voice"` |  chat bar上的语音图片 |
| `"zr_signal01"` |  声音大小01 |
| `"zr_signal02"` |  声音大小02 |
| `"zr_signal03"` |  声音大小03 |
| `"zr_signal04"` |  声音大小04 |
| `"zr_signal05"` |  声音大小05 |
| `"zr_signal06"` |  声音大小06 |
| `"zr_signal07"` |  声音大小07 |
| `"zr_signal08"` |  声音大小08 |


## 使用

> 参照Demo

```swift

	// 自定义More模块
    func contentForMore() -> [ZRMoreModel] {
        let model1 = ZRMoreModel(imageStr: "chatBar_colorMore_photo", title: "照片")
        let model2 = ZRMoreModel(imageStr: "chatBar_colorMore_camera", title: "拍摄")
        return [model1, model2]
    }
    
    // 自定义表情模块
    func contentForEmojis() -> [ZREmojisModel] {
        let models = emojis.map { (arg) -> ZREmojisModel in
            let (title, imgStr) = arg
            return ZREmojisModel(imageName: imgStr, text: title, type: .normal)
        }
        return models
    }
```


