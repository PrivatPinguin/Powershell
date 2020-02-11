
#create filePath
function createFilePath($path)
{
    #stdFileName
    $filename = 'list.txt'

	if ($path -like '*\')
	{
		$path = $path + $filename
	}
	else
	{
		$path = $path + '\' + $filename
	}
	return $path
}

#make path if empty
function createPath($path)
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
function userPath()
{	
	Do
	{
		$path = Read-Host -Prompt 'Enter a path or press -enter- for current path:'
		$path = createPath $path
	}
	While ( ( ($path -eq $null) -or ($path -eq '')  )  )

	return $path
}

#outputtext
function outputText($filePath)
{
	if (Test-Path $filePath)
	{
		Write-Host -ForegroundColor Cyan "`n" $filename -NoNewline
		Write-Host "was created in " -NoNewline
		Write-Host -ForegroundColor Cyan $path "`n"
	} 
	else
	{
		Write-Host -ForegroundColor Cyan "`n" $filename -NoNewline
		Write-Host " was not created`n" 
	}
}

#main
function initSkript()
{
    #asks for path input
    $path = userPath 
    
    ## clear path
    #$path = 'C:\'
    
    if(Test-Path $path)
    {
        #change direction
        if(Set-Location $path)
        {
            $filePath = createFilePath $path
    
            #delate if file exists
            if (Test-Path $filePath)
            {
    	        $confirmation = Read-Host "Remove path '"$filepath"' ? [y/n]"
    	        Do
    	        {
    	    	    if ($confirmation -ne "y")
	      	        {
	    		        break
	    	        }
                    else
                    {
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
    	        }
    	        while($confirmation -ne "y")
            }
        }
    }

    #outputtext
    outputText $filePath

    #waits for userinput
    pause
}

#begin
initSkript


# C:\Users\Alexander\Pictures\pr0