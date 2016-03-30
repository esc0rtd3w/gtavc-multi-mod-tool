#!/bin/sh

# GTA:VC APK/OBB Multi Mod Tool for Android

# Version 0.7

# by esc0rtd3w / crackacademy.com




# ------------------------------------------------------------------
# Setting some variables to use :)


#PATH="/usr/bin:/bin:$PATH"; export PATH


# Default namespace/package name
android_package_name=com.rockstargames.gtavc

# Default internal installed apk
android_data_app=data/app/com.rockstargames.gtavc-1.apk

# Default internal data path
android_data_path=data/data/com.rockstargames.gtavc

# Default DATA Directory on Android Device
android_data_sd=/sdcard/android/data/com.rockstargames.gtavc/files

# Default OBB Directory on Android Device
android_obb_path=/sdcard/android/obb/com.rockstargames.gtavc


# PERMISSIONS / ACTIVITIES

permission_WAKE_LOCK=WAKE_LOCK
permission_ACCESS_WIFI_STATE=ACCESS_WIFI_STATE
permission_WRITE_EXTERNAL_STORAGE=WRITE_EXTERNAL_STORAGE
permission_INTERNET=INTERNET
permission_VIBRATE=VIBRATE
permission_ACCESS_NETWORK_STATE=ACCESS_NETWORK_STATE
permission_BILLING=BILLING
permission_READ_PHONE_STATE=READ_PHONE_STATE
permission_CHECK_LICENSE=CHECK_LICENSE
permission_GET_ACCOUNTS=GET_ACCOUNTS
permission_BLUETOOTH=BLUETOOTH
permission_GTAVC=com.rockstargames.gtavc.GTAVC



# APK Specific
apk_file=com.rockstargames.gtavc-1.apk


# OBB Specific

# This is the exact filesize of the original OBB file
obb_size_default=1484069186
#TESTONLY--obb_size_default=8484069

# Default Padding Filename
obb_padding_file=gtavc-obb-padding.bin

# Default OBB File Name
obb_file=main.11.com.rockstargames.gtavc.obb

# Default Incomplete OBB Temp File for Resume
obb_file_temp=main.11.com.rockstargames.gtavc.obb.tmp



# Default Extract Paths
apk_extracted=gtavc_apk_dump
obb_extracted=gtavc_obb_dump


# Default Rebuild Names
apk_rebuild=gtavc-rebuild.apk
apk_rebuild_za=gtavc-rebuild-za.apk
apk_rebuild_signed=gtavc-rebuild-signed.apk
apk_rebuild_za_signed=gtavc-rebuild-za-signed.apk

apk_rebuild_tmp=gtavc-rebuild.zip
apk_rebuild_za_tmp=gtavc-rebuild-za.zip
apk_rebuild_signed_tmp=gtavc-rebuild-signed.zip
apk_rebuild_za_signed_tmp=gtavc-rebuild-za-signed.zip



# Default OBB Rebuilt File Name
obb_file_rebuild=main.11.com.rockstargames.gtavc.obb.rebuild

# Default OBB Rebuilt File Name (Padded)
obb_file_rebuild_padded=main.11.com.rockstargames.gtavc.obb.rebuild.padded

# Default OBB Rebuilt File Name (Zip Aligned)
obb_file_rebuild_za=main.11.com.rockstargames.gtavc.obb.rebuild.za

# Default OBB Rebuilt File Name (Zip Aligned / Padded)
obb_file_rebuild_za_padded=main.11.com.rockstargames.gtavc.obb.rebuild.za.padded



# Default Settings
data_settings=gta_vc.set

# Autosave Slot
data_save_auto=GTA3sf9.b



# Some binaries

local_7z=files/7z
local_adb=files/adb
local_apksign=java -Xmx512m -jar signapk.jar -w testkey.x509.pem testkey.pk8
local_zip=files/zip
local_zipalign=files/zipalign


# Current working folder
current_dir=$pwd


# ------------------------------------------------------------------





# ------------------------------------------------------------------
# Main Menu

main_menu()
{

echo
echo -----------------------------------------------
echo "GTA:VC APK/OBB Multi Mod Tool v0.7"
echo "esc0rtd3w / crackacademy.com"
echo -----------------------------------------------
echo
echo "Select An Action From Below:"
echo
echo
echo 1. Pull APK File
echo 2. Pull DEVICE/data/data Folder
echo 3. Pull SDCARD/android/data Folder
echo 4. Pull SDCARD/android/obb Folder
echo 5. Unpack APK File
echo 6. Create/Rebuild APK File
echo 7. Unpack OBB File
echo 8. Create/Rebuild OBB File
echo 9. Install APK File
echo 10. Push DEVICE/data/data Folder
echo 11. Push SDCARD/android/data Folder
echo 12. Push SDCARD/android/obb Folder
echo 13. Exit
echo

read  action

case "$action" in

"")

;;

"1")
pull_apk
;;

"2")
pull_datadata
;;

"3")
pull_data_sd
;;

"4")
pull_obb
;;

"5")
unpack_apk
;;

"6")
create_apk
;;

"7")
unpack_obb
;;

"8")
create_obb
;;

"9")
install_apk
;;

"10")
push_datadata
;;

"11")
push_data_sd
;;

"12")
push_obb
;;

"13")
exit
;;

*)

;;


esac
  
main_menu

}

# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Copy files from Android device for backup purposes


# Pull APK file from device
pull_apk()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Copying current installed APK file from Android device...."
echo
echo ---------------------------------------------------------------------

mkdir "apk"

chmod a+x adb
adb pull $android_data_app apk/

main_menu

}


# Pull "data/data" folder from device
pull_datadata()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Copying data/data folder from Android device...."
echo
echo ---------------------------------------------------------------------

mkdir "data/data/com.rockstargames.gtavc"

chmod a+x adb
adb pull $android_data_path data/data/com.rockstargames.gtavc

main_menu

}


# Pull "android/data" folder from sdcard
pull_data_sd()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Copying android/data folder from Android SD Card...."
echo
echo ---------------------------------------------------------------------

mkdir "android/data/com.rockstargames.gtavc/files"

chmod a+x adb
adb pull $android_data_sd android/data/com.rockstargames.gtavc/files

main_menu

}


# Pull OBB file from device
pull_obb()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Copying current OBB file from Android device...."
echo
echo ---------------------------------------------------------------------

mkdir "android/obb/com.rockstargames.gtavc/$obb_file"

chmod a+x adb
adb pull $android_obb_path/$obb_file android/obb/com.rockstargames.gtavc/$obb_file

#chmod a+x $local_adb
#$local_adb pull $android_obb_path/$obb_file $current_dir/$obb_file

main_menu

}

# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Unpack current APK file

unpack_apk()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Unpacking APK file to temp folder...."
echo
echo ---------------------------------------------------------------------

cd apk

mkdir "$apk_extracted"

7z x -y $apk_file -o$apk_extracted

cd ..

main_menu

}

# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Create/Rebuild current APK file

create_apk()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Creating a new APK File...."
echo
echo ---------------------------------------------------------------------

cd "apk/$apk_extracted"

7z a -mx0 $apk_rebuild_tmp *

mv $apk_rebuild_tmp $apk_rebuild

cd ..

mv "$apk_extracted/$apk_rebuild" ./

cd ..

zipalign_apk
#main_menu

}

# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Zip Align current APK file

zipalign_apk()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Zip Aligning the new APK File...."
echo
echo ---------------------------------------------------------------------

cp $local_zipalign apk/zipalign

cd "apk"

mv $apk_rebuild $apk_rebuild_tmp

chmod a+x zipalign
./zipalign -v -f 4 $apk_rebuild_tmp $apk_rebuild_za_tmp

mv $apk_rebuild_za_tmp $apk_rebuild_za

mv $apk_rebuild_tmp $apk_rebuild

rm zipalign

cd ..

sign_apk
#main_menu

}

# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Sign current APK file

sign_apk()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Signing the new APK File...."
echo
echo ---------------------------------------------------------------------

cd "apk"

mv $apk_rebuild_za ../$apk_rebuild_za

cd ..

mv $apk_rebuild_za files/$apk_rebuild_za

cd "files"

java -Xmx512m -jar signapk.jar testkey.x509.pem testkey.pk8 $apk_rebuild_za $apk_rebuild_za_signed
#$local_apksign $apk_rebuild_za $apk_rebuild_za_signed

mv $apk_rebuild_za_signed ../$apk_rebuild_za_signed
mv $apk_rebuild_za ../$apk_rebuild_za

cd ..

mv $apk_rebuild_za_signed apk/$apk_rebuild_za_signed
mv $apk_rebuild_za apk/$apk_rebuild_za

echo
echo $apk_rebuild_za_signed Successfully Built!
echo
echo If you seen ANY errors during this step, signing may have failed!
echo
echo Check for $apk_rebuild_za_signed in "/files/" directory.
echo
echo
echo Press a key to continue....
echo
echo

read -p "" tmp

main_menu

}

# ------------------------------------------------------------------




# ------------------------------------------------------------------
# Install current APK file

install_apk()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Installing APK File To Android Device...."
echo
echo ---------------------------------------------------------------------


chmod a+x $local_adb
$local_adb install apk/$apk_rebuild_za_signed

main_menu

}

# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Unpack current OBB file

unpack_obb()
{

#pull_obb

# Unpack the pulled OBB file to a tmp directory

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Decompressing OBB file to a temporary directory...."
echo
echo ---------------------------------------------------------------------

#chmod a+x $local_7z
#$local_7z x -o$obb_extracted $obb_file


7z x -o$obb_extracted $obb_file

main_menu

}
# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Create new OBB file

create_obb()
{

# Try to get into extracted OBB directory (will add a better method soon)

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Attempting to get into temporary directory...."
echo
echo ---------------------------------------------------------------------

cd $obb_extracted


# Zip the contents of the extracted OBB directory

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Creating rebuilt OBB file from contents of temporary directory...."
echo
echo ---------------------------------------------------------------------

#chmod a+x $local_zip
#$local_zip -r -0 -b *


# Cleanup leftover OBB temp files

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Deleting old OBB files in temporary directory...."
echo
echo ---------------------------------------------------------------------

rm -f $obb_padding_file
rm -f $obb_file
rm -f $obb_file_rebuild
rm -f $obb_file_rebuild_padded
rm -f $obb_file_rebuild_za
rm -f $obb_file_rebuild_za_padded

sleep 2


# Creating new OBB file from extracted folder
zip -r -0 -b *

#7z a -r -m0 -o$obb_extracted temp.zip $current_dir/$obb_extracted


# Rename the default output zip to a more suiting name

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Searching for newly built ZIP file...."
echo
echo ---------------------------------------------------------------------

#if [ -f "anim.zip" ]
#then

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Changing file extension from ZIP to OBB...."
echo
echo ---------------------------------------------------------------------

    #mv anim.zip $obb_file_rebuild
    
    obb_temp_zip=$(ls | grep .zip)
    
    mv $obb_temp_zip $obb_file_rebuild
    
    #mv $obb_file_rebuild ..
    
#else

#echo
#echo
#echo ---------------------------------------------------------------------
#echo
#echo "No input ZIP file found!"
#echo
#echo ---------------------------------------------------------------------

#fi




# SKIPPING THIS STEP FOR NOW UNTIL DETERMINED IF NEEDED
# Zip-Align to fix loading issues???

#echo
#echo
#echo ---------------------------------------------------------------------
#echo
#echo "Zip-Aligning OBB file...."
#echo
#echo ---------------------------------------------------------------------

#chmod a+x $local_zipalign
#$local_zipalign -f -v 4 $obb_file_rebuild $obb_file_rebuild_za



# Get File Size of Rebuilt OBB File

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Checking filesize of rebuilt OBB file...."
echo
echo ---------------------------------------------------------------------

get_filesize_rebuild=$(stat -c%s "$obb_file_rebuild")
#get_filesize_rebuild_za=$(stat -c%s "$obb_file_rebuild")
#get_filesize=$(stat --printf="%s" "$obb_file_rebuild"
#get_filesize_za=$(stat --printf="%s" "$obb_file_rebuild"


# Get Difference in Bytes between original and modified OBB files

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Checking difference in bytes between original and rebuilt OBB file...."
echo
echo ---------------------------------------------------------------------

get_size_diff_rebuild=$(($obb_size_default - $get_filesize_rebuild))
#get_size_diff_rebuild_za=$(($obb_size_default - $get_filesize_rebuild_za))



# Display some output to screen

echo
echo
echo ---------------------------------------------------------------------
echo
echo "File Status:"
echo
echo Filesize of Original OBB File: $obb_size_default
echo Filesize of Rebuilt OBB File: $get_filesize_rebuild
#echo $get_filesize_rebuild_za
echo Filesize of Padding File: $get_size_diff_rebuild
#echo $get_size_diff_rebuild_za
echo
echo ---------------------------------------------------------------------



# Pad OBB File to 1,484,069,186 bytes

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Attempting to match size of rebuilt file to original OBB file...."
echo
echo "This may take several minutes, please be patient!"
echo ---------------------------------------------------------------------

dd if=/dev/zero of=$obb_padding_file bs=$get_size_diff_rebuild count=1
cat $obb_file_rebuild $obb_padding_file > $obb_file_rebuild_padded
rm -f $obb_padding_file


# Some non-working code....will delete later
#dd if=$obb_file_rebuild of=$obb_file_rebuild_padded bs=1 count=$get_filesize_rebuild seek=$get_filesize_rebuild conv=notrunc
#dd if=$obb_file_rebuild of=$obb_file_rebuild_padded bs=1 count=$get_size_diff_rebuild seek=$(stat -c%s $obb_file_rebuild)
#dd if=$obb_file_rebuild_za of=$obb_file_rebuild_za_padded bs=1 count=$get_size_diff_rebuild_za seek=$(stat -c%s $obb_file_rebuild_za)



# Try to get out of temp folder

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Attempting to get out of temporary directory...."
echo
echo ---------------------------------------------------------------------

cd ..

#push_obb
main_menu

}
# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Push /data/data

push_datadata()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Copying data/data folder back to Android device...."
echo
echo ---------------------------------------------------------------------


chmod a+x adb
adb push data/data/com.rockstargames.gtavc $android_data_path

main_menu

}

# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Push /sdcard/android/data

push_data_sd()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Copying android/data folder back to Android SD Card...."
echo
echo ---------------------------------------------------------------------


chmod a+x adb
adb push android/data/com.rockstargames.gtavc/files $android_data_sd

main_menu

}

# ------------------------------------------------------------------



# ------------------------------------------------------------------
# Push OBB file back to android device

push_obb()
{

echo
echo
echo ---------------------------------------------------------------------
echo
echo "Copying rebuilt OBB file to Android device...."
echo
echo "This may take several minutes, please be patient!"
echo
echo ---------------------------------------------------------------------

#chmod a+x $local_adb
#$local_adb push .$obb_file_rebuild_padded $android_obb_path/$obb_file


chmod a+x adb
adb push $obb_extracted/$obb_file_rebuild_padded $android_obb_path/$obb_file
#adb push $obb_file_rebuild_za_padded $android_obb_path/$obb_file

}

main_menu

# ------------------------------------------------------------------


# Actions to do

# For now you MUST uncomment each one to use. This will be changed after more testing is done


# Force going to Main Menu first
main_menu


#pull_apk

#pull_datadata

#pull_data_sd

#pull_obb

#unpack_obb

#create_obb






