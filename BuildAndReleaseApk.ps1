$path = ".\platforms\android\build\outputs\apk\"
$output = $path + "android-release-unsigned.apk"
$pathToKeyStore = ".\"
$keystore = "my.keystore"
$android = "C:\Program Files (x86)\Android\android-sdk\build-tools"
$outputApkName = "MyApkName.apk"

Clear-Host

if (!(Test-Path $output))
{
    Write-Host "File doesn't exist";
    exit 1;
}

if (!(Test-Path ($pathToKeyStore+ $keystore)))
{
    Write-Host "Keystore doesn't exist in " + $pathToKeyStore;
    exit 1;
}

Remove-Item -Recurse $path 
cordova build android --release

Copy-Item -Path $keystore -Destination $path -Force

jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ($path + $keystore) $output 

$AndroidPath = Get-ChildItem $android | Sort Name -Descending | Select -First 1 

$AndroidVersion = $android + "\" + $AndroidPath.Name

Clear-Host

cmd /c $AndroidVersion\zipalign -v 4  $output ($path + $outputApkName)
exit 0;