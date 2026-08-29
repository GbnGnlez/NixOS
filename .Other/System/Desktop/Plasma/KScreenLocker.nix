# https://github.com/nix-community/plasma-manager/blob/trunk/modules/kscreenlocker.nix

{ ... }:

{
  programs.plasma = {
    enable = true;

    kscreenlocker = {
      autoLock = false; # Whether the screen will be locked after the specified time.
      lockOnResume = false; # Whether to lock the screen when the system resumes from sleep.
      timeout = 0; # Sets the timeout in minutes after which the screen will be locked.
      passwordRequired = false; # Whether the user password is required to unlock the screen.
      passwordRequiredDelay = 0; # The time it takes in seconds for the password to be required after the screen is locked.
    };

    shortcuts."ksmserver"."Lock Session" = [ ];
  };
}
