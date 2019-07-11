import 'package:flutter/services.dart';
import 'dart:async';


class AsrManager {

  static const MethodChannel _channel = const MethodChannel("asr_plugin");

  /**
   * @method  开始录音
   * @description 描述一下方法的作用
   * @date: 2019-07-02 15:31
   * @author: 作者名
   * @param
   * @return
   */
  static Future<String> start({Map parameter}) async {
    return await _channel.invokeMethod("start",parameter??{});
  }

  /**
   * @method  停止录音
   * @description 描述一下方法的作用
   * @date: 2019-07-02 15:32
   * @author: 作者名
   * @param 
   * @return 
   */
  static Future<String> stop() async {
    return await _channel.invokeMethod("stop");
  }

  /**
   * @method  取消录音
   * @description 描述一下方法的作用
   * @date: 2019-07-02 15:32
   * @author: 作者名
   * @param 
   * @return
   */
  static Future<String> cancel() async {
    return await _channel.invokeMethod("cancel");
  }
}