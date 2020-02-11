
#stdFileName
$filename = 'list.txt'

#create filePath
function createFilePath([string]$path)
{
	if ($path -like '*\')
	{
		$filePath = $path + $filename
	}
	else
	{
		$filePath = $path + '\' + $filename
	}
	return $filePath
}

#make path if empty
function createPath([string]$path)
{
	if( ( ($path -eq $null) -or ($path -eq '')  )  )
	{
		$path = get-location
		$path = "$path"
	} 
	#Test-Path -Path $path
	return $path
}

#asks for path input
function usePath([string]$path)
{	
	#Do
	#{
		Do
		{
			$path = Read-Host -Prompt 'Enter a path or press -enter- for current path:'
			$path = createPath $path
		}
		While ( ( ($path -eq $null) -or ($path -eq '')  )  )
	#}
	#While ( !(Test-Path -Path $path) )
	return $path
}

#outputtext
function outputText()
{
	if ( (Test-Path ( $filePath ) ) -and ($filePath -like '*\list.txt') )
	{
		Write-Host -ForegroundColor Cyan "`n" $filename -NoNewline
		Write-Host " was created in " -NoNewline
		Write-Host -ForegroundColor Cyan $path "`n"
	} 
	else
	{
		Write-Host -ForegroundColor Cyan "`n" $filename -NoNewline
		Write-Host " was not created`n" 
	}
}

#asks for path input
$path = usePath

#change direction
Set-Location -Path $path

#function createFilePath
$filePath = createFilePath $path

#delate if file exists
if (Test-Path ( $filePath ))
{
	$confirmation = Read-Host "Remove path '"$filepath"' ? [y/n]"
	Do
	{
		if ($confirmation -ne "y")
		{
			break
		}
		#remove existing file
		Remove-Item $filePath -Confirm

		#create File
		New-Item -Path $filePath -ItemType File

		#add content to file
		foreach ($objPath in (Get-ChildItem -Path $path ))
		{
			Add-Content $filePath $objPath 
		}
	}
	while($confirmation -ne "y")
}

#outputtext
outputText

#waits for userinput
pause
 