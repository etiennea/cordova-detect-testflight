 import UIKit

enum AppConfiguration {
  case Debug
  case TestFlight
  case AppStore
}

struct Config {
  private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

  static var isDebug: Bool {
    #if DEBUG
      return true
    #else
      return false
    #endif
  }

  static var appConfiguration: AppConfiguration {
    if isDebug {
      return .Debug
    } else if isTestFlight {
      return .TestFlight
    } else {
      return .AppStore
    }
  }
}


@objc(DetectTestFlight) class DetectTestFlight : CDVPlugin {
  
  @objc(echo:)
  func echo(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: Config.appConfiguration == AppConfiguration.TestFlight ? "true" : "false"
      )
    

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
}
