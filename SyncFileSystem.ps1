$SourceFolder = "D:\Source"
$TargetFolder = "D:\Target\"

$SourceFolderItems = Get-ChildItem -Recurse -Path $SourceFolder
$TargetFolderItems = Get-ChildItem  -Recurse -Path $TargetFolder


try {
    
    $Result = Compare-Object -ReferenceObject $SourceFolderItems -DifferenceObject $TargetFolderItems 


    # Symbol == it means that it exists in both sides
    # Symbol <= it means that it exists in the SourceFolder but not in the TargetFolder
    # Symbol => it means that it exists in the Target but not in the Source

    foreach ($folder in $Result) {
        if ($folder.SideIndicator -eq "<=") {
            $FullSourceObject = $folder.InputObject.FullName
            $FullTargetObject = $folder.InputObject.FullName.Replace($SourceFolder, $TargetFolder)

            Write-Host "Attempt to copy the following: " $FullSourceObject
            Copy-Item -Path $FullSourceObject -Destination $FullTargetObject
        }
    }
}
catch {
    Write-Error -Message "Something bad happened!" -ErrorAction Stop
}
