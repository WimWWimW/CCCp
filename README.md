# CCCp
Canon Camera Command Program based on EDSDK
-------------------------------------------
Since I have stopped using Windows, 
this project is no longer maintained.
-------------------------------------------

This is the full and working Delphi source to command a canon DSLR from your computer. Working functions include:

- setting exposure properties
- shooting
- live View
- zoom and navigation during live view
- focusing during live view
- mirror lock-up (yes!)
- histograms
- custom file naming

Not working is showing RAW-files as image (tip me if you know how it can be done - I know it should be possible!).


The application is geared towards shooting a stack of pictures by driving the focusing motor of the lens. The underlying object model is completely generic though.

* Tested ONLY with canon Eos 7D mk 1
* Delphi 7; Windows xp

Since this application was developed on xp, the newest dll's that would run was 3.2.20.2, which is newer than the documnetion suggest ought to be possible. I have included the headers for EDSDK 3.6 and 13.12 too, but these have not been tested. The header files seems to be reasonably conservative though, so it should not be hard to get these working. Contact me if you need other versions.

NOTE ON THE ARCHITECTURE
------------------------
The original header files are automatically converted to EDSDKapi.pas, EDSDKtype.pas, and EDSDKerror.pas. The raw dll-interface of EDSDKapi.pas is wrapped into native pascal functions, raising proper exceptions instead of returning numeric error codes, and getting rid of most of the pointer stuff. A sequence of classes and subclasses than takes care of much of the complecity of programming against the EDSDK.
During parsing of the original header files, two auxiliary files are created (propNames containing property names, and EDSDKstrings.ini with error strings and domain variables) to get access to the string representation of the many variables. These can be used in error messages and e.g. comboboxes. Make sure that the EDSDKstrings.ini in your runtime folder corresponds with the version of the EDSDK version.


