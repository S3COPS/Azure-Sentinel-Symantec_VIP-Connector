function Get-FileName($initialDirectory)
{   
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
    Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.pfx)| *.pfx"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}
Write-Host "Browse to the pfx certificate file to be encoded"
Start-Sleep -s 1
$file = get-filename
$filePath = Split-Path -Path $file -Parent

$fileContentBytes = get-content $file -Encoding Byte
[System.Convert]::ToBase64String($fileContentBytes) | Out-File  $filePath\'pfx-encoded.txt'
Start-Sleep -s 1
Write-Host "The Base64 encoded Certificate has been written to"
Write-Host $filePath