# modules/darwin/desktop/defaults.nix
{ ... }:
{
  system.defaults = {
    CustomUserPreferences = {
      NSGlobalDomain = {
        NSCloseAlwaysConfirmsChanges = false;
        AppleSpacesSwitchOnActivate = true;
      };
      "com.apple.Music" = {
        userWantsPlaybackNotifications = false;
      };
      "com.apple.ActivityMonitor" = {
        UpdatePeriod = 1;
      };
      "com.apple.TextEdit" = {
        SmartQuotes = false;
        RichText = false;
      };
      "com.apple.spaces" = {
        "spans-displays" = false;
      };
      "com.apple.menuextra.clock" = {
        DateFormat = "EEE d MMM HH:mm:ss";
        FlashDateSeparators = false;
      };
    };

    magicmouse = {
      MouseButtonMode = "TwoButton";
    };

    screencapture = {
      disable-shadow = true;
      location = "~/Desktop";
      show-thumbnail = true;
      type = "png";
      target = "file";
    };

    smb = {
      NetBIOSName = null;
      ServerDescription = null;
    };

    spaces = {
      spans-displays = false;
    };

    trackpad = {
      ActuationStrength = 1;
      Clicking = true;
      Dragging = true;
      FirstClickThreshold = 1;
      SecondClickThreshold = 2;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
      TrackpadThreeFingerTapGesture = 0;
    };

    universalaccess = {
      closeViewScrollWheelToggle = false;
      closeViewZoomFollowsFocus = false;
      reduceTransparency = false;
      mouseDriverCursorSize = 1.0;
    };

    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = true;
    };

    LaunchServices = {
      LSQuarantine = true;
    };

    WindowManager = {
      AppWindowGroupingBehavior = true;
      AutoHide = false;
      EnableStandardClickToShowDesktop = false;
      EnableTiledWindowMargins = false;
      GloballyEnabled = false;
      HideDesktop = false;
      StageManagerHideWidgets = false;
      StandardHideDesktopIcons = false;
      StandardHideWidgets = false;
    };

    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = null;
      "com.apple.sound.beep.sound" = null;
    };

    NSGlobalDomain = {
      _HIHideMenuBar = false;
      "com.apple.keyboard.fnState" = false;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.sound.beep.feedback" = 0;
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.springing.delay" = 1.0;
      "com.apple.springing.enabled" = null;
      "com.apple.swipescrolldirection" = true;
      "com.apple.trackpad.enableSecondaryClick" = true;
      "com.apple.trackpad.forceClick" = false;
      "com.apple.trackpad.scaling" = null;
      "com.apple.trackpad.trackpadCornerClickBehavior" = null;
      AppleEnableMouseSwipeNavigateWithScrolls = true;
      AppleEnableSwipeNavigateWithScrolls = true;
      AppleFontSmoothing = null;
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      AppleKeyboardUIMode = null;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      ApplePressAndHoldEnabled = false;
      AppleScrollerPagingBehavior = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;
      AppleShowScrollBars = "WhenScrolling";
      AppleSpacesSwitchOnActivate = true;
      AppleTemperatureUnit = "Celsius";
      AppleWindowTabbingMode = "always";
      InitialKeyRepeat = 15; # slider values: 120, 94, 68, 35, 25, 15
      KeyRepeat = 2; # slider values: 120, 90, 60, 30, 12, 6, 2
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticWindowAnimationsEnabled = true;
      NSDisableAutomaticTermination = null;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSScrollAnimationEnabled = true;
      NSTableViewDefaultSizeMode = 2;
      NSTextShowsControlCharacters = false;
      NSUseAnimatedFocusRing = true;
      NSWindowResizeTime = 2.0e-2;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
    };

    loginwindow = {
      autoLoginUser = null;
      DisableConsoleAccess = false;
      GuestEnabled = false;
      LoginwindowText = null;
      PowerOffDisabledWhileLoggedIn = false;
      RestartDisabled = false;
      RestartDisabledWhileLoggedIn = false;
      SHOWFULLNAME = false;
      ShutDownDisabled = false;
      ShutDownDisabledWhileLoggedIn = false;
      SleepDisabled = false;
    };
  };

  system.startup.chime = false;
}
