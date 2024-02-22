import SwiftUI
import DeckUI

extension ContentView {
  var deck: Deck {
    Deck(title: "Configuring Apps Remotely", theme: .egeniq) {
      
      // MARK: Title
      Slide(alignment: .center) {
        Title("""
        Taking care of apps
        """)
        Words("Lunch lecture")
        Words("22 february 2024")
      }
      
      // MARK: Intro
      Slide {
        Title("Configuring apps remotely?")
        Words("""
        A simple but effective way to manage apps remotely.
        """)
        Space()
        Words("""
        Create a simple configuration file that is easy to maintain and host, yet provides important flexibility to specify settings based on your needs.
        """)
      }
      
      Slide {
        Title("What do we need?") //, subtitle: "Which situations did we encounter?")
        Columns {
          Column {
            Bullets(style: .bullet) {
              Words("no dependency on specific third party service")
              Words("one static config file for all platforms")
              Words("settings for all common types")
              Words("human readable")
              Words("resilient")
              Words("secure and verifiable")
              Words("backwards compatible")
            }
          }
        }
      }
      
      Slide {
        Title("Which situations did we encounter?")
        Columns {
          Column {
            Bullets(style: .bullet) {
              Words("override per platform")
              Words("override per platform version")
              Words("override per app version")
              Words("override per variant")
              Words("override per environment")
              Words("override per build variant")
              Words("override per language")
              Words("schedule changes")
            }
          }
        }
      }
      
      Slide {
        Title("Anything else?") // , subtitle: "Which situations did we encounter?")
        Columns {
          Column {
            Bullets(style: .bullet) {
              Words("A/B tests")
              //              Words("typos")
              //              Words("ability to override per app version")
              //              Words("ability to override per variant")
              //              Words("ability to override per environment")
              //              Words("ability to override per build variant")
              //              Words("ability to override per language")
              //              Words("ability to schedule changes")
            }
          }
        }
      }
      // JSON
      // JSON 5 with comments
      // YAML
      
      Slide(alignment: .center) {
        Title("care")
        Words("Configure Apps REmotely")
        Space()
        Words("`brew install egeniq/app-utilities/care`")
      }
      Slide {
        Code {
          """
          $> care
          OVERVIEW: Configure apps remotely.
          
          A simple but effective way to manage apps remotely.
          
          Create a simple configuration file that is easy to maintain and host, yet provides important flexibility to specify
          settings based on your needs.
          
          USAGE: care <subcommand>
          
          OPTIONS:
            --version               Show the version.
            -h, --help              Show help information.
          
          SUBCOMMANDS:
            init                    Prepare a new configuration.
            verify                  Verify that the configuration is valid.
            resolve                 Resolve a configuration for an app to verify output.
            prepare                 Prepare a configuration for publication.
          
            See 'care help <subcommand>' for detailed help.
          """
        }
      }
      
      Slide {
        Code {
          """
          $> care help init
          OVERVIEW: Prepare a new configuration.
          
          USAGE: care init [--kind <kind>] <output-file>
          
          ARGUMENTS:
            <output-file>           The file that will contain the configuration.
          
          OPTIONS:
            --kind <kind>           The kind of configuration file. (values: yaml, json; default: yaml)
            --version               Show the version.
            -h, --help              Show help information.
          """
        }
      }
      
      Slide {
        Code {
          """
          $> care init --kind yaml appconfig.yaml
          This configuration is created.
          [HINT] Use the resolve command to verify the output is as expected for an app.
          [HINT] Use the prepare command to prepare the configuration for publication.
          """
        }
      }
      
      Slide {
        Code {
          """
          # yaml-language-server: $schema=./appremoteconfig.schema.json
          $schema: ./appremoteconfig.schema.json
          
          # Settings for the current app.
          settings:
            foo: 42
            coolFeature: false
          
          # Keep track of keys that are no longer in use.
          deprecatedKeys:
          - bar
          
          # Override settings
          overrides:
          - matching:
            # If any of the following combinations match
            - appVersion: <=0.9.0
              platform: Android
            - appVersion: <1.0.0
              platform: iOS
            - platformVersion: <15.0.0
              platform: iOS.iPad
            # These settings get overriden.
            settings:
              bar: low
           
          # Or release a new feature at a specific time
          - schedule:
              from: '2024-12-31T00:00:00Z'
            settings:
              coolFeature: true
              
          # Store metadata here
          meta:
            author: Your Name
          """
        }
      }
      
      Slide {
        Code {
          """
          $> care help verify
          OVERVIEW: Verify that the configuration is valid.

          USAGE: care verify <input-file>

          ARGUMENTS:
            <input-file>            The file that contains the configuration.

          OPTIONS:
            --version               Show the version.
            -h, --help              Show help information.
          """
        }
      }
      
      Slide {
        Code {
          """
          $> care verify appconfig.yaml
          This configuration has 3 issue(s).
          [INFO] This configuration is in YAML. This is not suitable for publication. Use the prepare command to convert to JSON. - /
          [ERROR] Expected at least one of keys from and until. - /overrides[1]/schedule
          [ERROR] Key 'coolFaeture' is not used in settings or listed in deprecated keys. - /overrides[1]/settings
          """
        }
      }
      
      Slide {
        Code {
          """
          $> care verify appconfig.yaml
          This configuration is valid.
          [INFO] This configuration is in YAML. This is not suitable for publication. Use the prepare command to convert to JSON. - /
          [HINT] Use the resolve command to verify the output is as expected for an app.
          [HINT] Use the prepare command to prepare the configuration for publication.
          """
        }
      }
      
      Slide {
        Code {
          """
          $> care help resolve
          OVERVIEW: Resolve a configuration for an app to verify output.

          USAGE: care resolve <input-file> [--app-version <app-version>] [--date <date>] [--platform <platform>] [--platform-version <platform-version>] [--variant <variant>] [--build-variant <build-variant>] [--language <language>]

          ARGUMENTS:
            <input-file>            The file that contains the configuration.

          OPTIONS:
            -v, --app-version <app-version>
                                    The version of the app. (default: 1.0.0)
            -d, --date <date>       The date the app runs at in ISO8601 format. (default: now)
            -p, --platform <platform>
                                    The platform the app runs on. (values: iOS, iOS.iPhone, iOS.iPad, iOS.TV, 
                                    iOS.CarPlay, iOS.Mac, macOS, watchOS, visionOS, Android, Android.phone,
                                    Android.tablet, Android.TV, WearOS, unknown;
                                    default: iOS)
            --platform-version <platform-version>
                                    The version of the platform the app runs on. (default: 1.0.0)
            --variant <variant>     The variant of the app.
            --build-variant <build-variant>
                                    The build variant of the app. (values: release, debug, unknown; default: release)
            --language <language>   The 2 character code of the language the app runs in.
            --version               Show the version.
            -h, --help              Show help information.

          """
        }
      }
      
      Slide {
        Code {
          """
          $> care resolve appconfig.yaml -p iOS --platform-version 16  -v 1.0.1
          Resolving for:
            platform            : iOS
            platform version    : 16.0.0
            app version         : 1.0.1
            build variant       : release

          Settings on 2024-02-22 11:40:00 +0000:
            coolFeature         : false
            foo                 : 42

          Settings on 2024-12-31 00:00:00 +0000:
            coolFeature         : false -> true
            foo                 : 42

          No further overrides scheduled.
          """
        }
      }
      
      Slide {
        Code {
          """
          $> care help prepare
          OVERVIEW: Prepare a configuration for publication.

          USAGE: care prepare <input-file> <output-file>

          ARGUMENTS:
            <input-file>            The file that contains the configuration.
            <output-file>           The file that will contain the configuration suitable for publication.

          OPTIONS:
            --version               Show the version.
            -h, --help              Show help information.
          """
        }
      }
      
      Slide {
        Code {
          """
          $> care prepare appconfig.yaml appconfig.json
          This configuration is prepared.
          
          $> cat appconfig.json
          {"$schema":".\\/Schema\\/appremoteconfig.schema.json","meta":{"author":"Your Name"},"overrides":[{"matching":[{"platform":"Android","appVersion":"<=0.9.0"},{"platform":"iOS","appVersion":"<1.0.0"},{"platformVersion":"<15.0.0","platform":"iOS.iPad"}],"settings":{"bar":"low"}},{"settings":{"coolFeature":true},"schedule":{"from":"2024-12-31T00:00:00Z"}}],"deprecatedKeys":["bar"],"settings":{"foo":42,"coolFeature":false}}⏎
          """
        }
      }
      
      Slide {
        Code(.swift) {
          """
          import AppRemoteConfigService
          import AppRemoteConfigMacros
          import Dependencies
          import DependenciesMacros
          import Foundation
          import Perception
          
          @AppRemoteConfigValues @Perceptible
          public class Values {
            public private(set) var coolFeature: Bool = false
            public private(set) var foo: Int = 41
          }
          
          @DependencyClient
          public struct AppRemoteConfigClient {
            public var values: () -> Values = { Values() }
          }
          
          extension DependencyValues {
            public var configClient: AppRemoteConfigClient {
              get { self[AppRemoteConfigClient.self] }
              set { self[AppRemoteConfigClient.self] = newValue }
            }
          }
          
          extension AppRemoteConfigClient: TestDependencyKey {
            public static let testValue = Self()
          }
          
          extension AppRemoteConfigClient: DependencyKey {
            public static let liveValue = {
              let url = URL(string: "https://www.example.com/config.json")!
              let values = Values()
              let service = AppRemoteConfigService(url: url, apply: values.apply(settings:))
              return Self(values: { values })
            }()
          }
          """
        }
      }
      
      Slide {
        Code(.swift) {
          """
          @AppRemoteConfigValues @Perceptible
          public class Values {
            public private(set) var coolFeature: Bool = false
            public private(set) var foo: Int = 41
          }
          
          extension AppRemoteConfigClient: DependencyKey {
            public static let liveValue = {
              let url = URL(string: "https://www.example.com/config.json")!
              let values = Values()
              let service = AppRemoteConfigService(url: url, apply: values.apply(settings:))
              return Self(values: { values })
            }()
          }
          """
        }
      }
      
      Slide {
        Code(.swift) {
          """
          @AppRemoteConfigValues @Perceptible
          public class Values {
            public private(set) var coolFeature: Bool = false
            public private(set) var foo: Int = 41
            public init(
              coolFeature: Bool = false,
              foo: Int = 41
            ) {
              self.coolFeature = coolFeature
              self.foo = foo
            }
            
            func apply(settings: [String: Any]) throws {
              var allKeys = Set(settings.keys)
              var incorrectKeys = Set<String>()
              var missingKeys = Set<String>()
              
              if let newValue = settings["coolFeature"] as? Bool  {
                coolFeature = newValue
                allKeys.remove("coolFeature")
              } else {
                coolFeature = false
                if allKeys.contains("coolFeature") {
                  allKeys.remove("coolFeature")
                  incorrectKeys.insert("coolFeature")
                } else {
                  missingKeys.insert("coolFeature")
                }
              }
              
              if let newValue = settings["foo"] as? Int  {
                foo = newValue
                allKeys.remove("foo")
              } else {
                foo = 41
                if allKeys.contains("foo") {
                  allKeys.remove("foo")
                  incorrectKeys.insert("foo")
                } else {
                  missingKeys.insert("foo")
                }
              }
              
              if !allKeys.isEmpty || !incorrectKeys.isEmpty || !missingKeys.isEmpty {
                throw AppRemoteConfigServiceError.keysMismatch(unhandled: allKeys, incorrect: incorrectKeys, missing: missingKeys)
              }
            }
          }
          """
        }
      }
      
      

      Slide {
        Code(.swift) {
          """
          struct MyView: View {
            @Dependency(\\.configClient) var configClient
              
            public var body: some View {
              WithPerceptionTracking { // For iOS 15 & 16 bwc support
                if configClient.values().coolFeature {
                  Text("Cool feature is now available!")
                }
              }
            }
          }
          """
        }
      }
      
      Slide {
        Code(.swift) {
           """
           struct MyView: View {
             @Dependency(\\.configClient) var configClient
               
             public var body: some View {
               WithPerceptionTracking { // For iOS 15 & 16 bwc support
                 if true {
                   Text("Cool feature is now available!")
                 }
               }
             }
           }
           """
        }
      }

      Slide {
        Code(.swift) {
           """
           public struct CoolFeatureEnabled {
             fileprivate init() { }
           }

           @AppRemoteConfigValues @Perceptible
           public class Values {
             private var coolFeature: Bool = false
             public var coolFeatureEnabled: CoolFeatureEnabled? { coolFeature ? CoolFeatureEnabled() : nil }
           }
           
           struct MyView: View {
             @Dependency(\\.configClient) var configClient
               
             public var body: some View {
               WithPerceptionTracking { // For iOS 15 & 16 bwc support
                 if let coolFeatureEnabled = configClient.values().coolFeatureEnabled {
                   CoolFeature(enabled: coolFeatureEnabled)
                 }
               }
             }
           }

           struct CoolFeature: View {
             let enabled: CoolFeatureEnabled
            
             var body: some View {
               Text("A cool feature is now available!")
             }
           }
           """
        }
      }

      Slide {
        Title("Android")
        Words("You can compile the `AppRemoteConfig` module for Android using Scade.")
        Code {
          """
          /Applications/Scade.app/Contents/PlugIns/ScadeSDK.plugin/Contents/Resources/Libraries/scd/bin/scd \\
            archive \\
            --type android-aar \\
            --path . \\
            --platform android-arm64-v8a \\
            --platform android-x86_64 \\
            --android-ndk ~/Library/Android/sdk/ndk/26.1.10909125 \\
            --generate-android-manifest \\
            --android-gradle /Applications/Scade.app/Contents/PlugIns/ScadeSDK.plugin/Contents/Resources/Libraries/ScadeSDK/thirdparty/gradle
          """
        }
      }
      
      Slide {
        Title("Android")
        Columns {
          Column {
            Bullets(style: .bullet) {
              Words("via Java Native Interface")
              Words("about 40 MB for Unicode")
              Words("about 16 MB for Foundation")
              Words("App Thinning equivalent?")
              Words("transpiler?")
            }
          }
        }
      }
      
      Slide(alignment: .center) {
        Title("Questions?", subtitle: "Feature requests?")
      }

      Slide {
        Title("Relevant Links")

        Words("Library:")
        Words("github.com/egeniq/app-remote-config")
        Space()
        Words("care")
        Words("`brew install egeniq/app-utilities/care`")
//        Words("This presentation:")
//        Words("github.com/johankool/configuring-apps-remotely")
//        Space()
//        Words("Presentation created with:")
//        Words("github.com/joshdholtz/DeckUI")
      }
    }
  }
}

public struct Space: ContentItem {
  public let id = UUID()
    let height: CGFloat
    
    public init(_ height: CGFloat = 60) {
        self.height = height
    }
    
    public func buildView(theme: Theme) -> AnyView {
        return AnyView(
          Spacer().frame(height: height)
        )
    }
}
