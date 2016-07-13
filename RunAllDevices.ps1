Clear-Host
$path = "C:\projects\";


$args = '"devices';
$output = cmd /c adb devices 2`>`&1;


$cmd = "";
$add = $false;

for($i=1; $i -le $output.Length; $i++)
{
    if (-Not $output[$i])
    {
        continue;
    }
    
    if ($add){
        $cmd = $cmd + " & ";
    }
    
    $cmd = $cmd + "ionic run android --target=" + $output[$i].Split("`t", [System.StringSplitOptions]::RemoveEmptyEntries)[0];
    $add = $true;    
}
Set-Location -Path $path 
cmd /c $cmd
