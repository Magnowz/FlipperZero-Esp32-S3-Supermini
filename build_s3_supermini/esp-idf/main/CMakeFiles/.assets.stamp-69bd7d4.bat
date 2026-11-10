@echo off
cd /D "G:\Projetos Esp32\FlipperZero-Esp32-S3-Supermini\build_s3_supermini\esp-idf\main" || (set FAIL_LINE=2& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E remove_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root" || (set FAIL_LINE=3& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E make_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets" || (set FAIL_LINE=4& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E make_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/example_apps_assets" || (set FAIL_LINE=5& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/examples/example_apps_assets/files" "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/example_apps_assets" || (set FAIL_LINE=6& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E make_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/subghz" || (set FAIL_LINE=7& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/subghz/resources" "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/subghz" || (set FAIL_LINE=8& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E make_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/js_app" || (set FAIL_LINE=9& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/system/js_app/examples" "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/js_app" || (set FAIL_LINE=10& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E make_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/lfrfid" || (set FAIL_LINE=11& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/lfrfid/resources" "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/lfrfid" || (set FAIL_LINE=12& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E make_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/nfc" || (set FAIL_LINE=13& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/nfc/resources" "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/nfc" || (set FAIL_LINE=14& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E make_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/bad_usb" || (set FAIL_LINE=15& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/bad_usb/resources" "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/bad_usb" || (set FAIL_LINE=16& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E make_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/clock" || (set FAIL_LINE=17& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E copy_directory "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/applications/main/clock_app/resources" "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/ext/apps_assets/clock" || (set FAIL_LINE=18& goto :ABORT)
C:\Espressif\tools\cmake\3.30.2\bin\cmake.exe -E touch "G:/Projetos Esp32/FlipperZero-Esp32-S3-Supermini/build_s3_supermini/esp-idf/main/generated/fam_runtime_root/.assets.stamp" || (set FAIL_LINE=19& goto :ABORT)
goto :EOF

:ABORT
set ERROR_CODE=%ERRORLEVEL%
echo Batch file failed at line %FAIL_LINE% with errorcode %ERRORLEVEL%
exit /b %ERROR_CODE%