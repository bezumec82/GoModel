#All used variables in one place
Set-Variable -Name GOROOT   -Value "h:\Go"
Set-Variable -Name GOPATH   -Value "$(Resolve-Path ${pwd}\..\..\..\..)"
Set-Variable -Name GOBIN    -Value $($GOPATH + "\bin")
Set-Variable -Name GOLANG   -Value $($GOROOT + "\bin")
Set-Variable -Name GCCPTH   -Value "h:\mingw-w64\x86_64-4.8.5-posix-sjlj-rt_v4-rev0\mingw64\bin\"
Set-Variable -Name LIBUSB_PTH       -Value "h:\Libraries\libusb-1.0.22"
Set-Variable -Name LIBUSB_INC_PTH   -Value $($LIBUSB_PTH + "\include\libusb-1.0")
Set-Variable -Name LIBUSB_LIB_PTH   -Value $($LIBUSB_PTH + "\MinGW64\static")
Set-Variable -Name LIBUSB_DLL_PTH   -Value $($LIBUSB_PTH + "\MinGW64\dll")

Write-Host "Setting paths" -ForegroundColor Yel
#golang
Write-Host ("Adding path to the golang compiler " +`
"to the PATH environment variable") -ForegroundColor Yel
Set-Item -Path Env:Path -Value ($GOLANG + ";" + $Env:Path)
Write-Host $Env:Path -ForegroundColor Cyan
Write-Host $(go version) -ForegroundColor Magenta

Write-Host ("GOROOT = " + $(Resolve-Path $Env:GOROOT)) -ForegroundColor Cyan
Set-Item Env:GOPATH -Value $($GOPATH)
Write-Host ("GOPATH = " + $(Resolve-Path $Env:GOPATH)) -ForegroundColor Cyan

# Usually I'm creating separate folder for all my golang projects
# For example 'd:/PROJECTS/GO'
# GOPATH = 'src' <- 'github.com' <- github owner <- project
$GOBIN = "$Env:GOPATH\bin"
If(!(test-path $GOBIN))
{
    Write-Host "Creating $GOBIN directory" -ForegroundColor Yellow
    New-Item -Path $GOBIN -ItemType Directory
} else {
    Write-Host "Path $GOBIN exists" -ForegroundColor Green
}
Set-Item Env:GOBIN -Value (Resolve-Path $GOBIN)
Write-Host ("GOBIN = " + $(Resolve-Path $Env:GOBIN)) -ForegroundColor Cyan

#mingw-w64 4.8.5
Set-Item Env:GCCPTH -Value $GCCPTH
Write-Host ("GCC path = " + $(Resolve-Path $Env:GCCPTH)) -ForegroundColor Cyan
Write-Host ("Adding path to the GCC " +`
"to the PATH environment variable") -ForegroundColor Yellow
Set-Item -Path Env:Path -Value ($Env:GCCPTH + ";" + $Env:Path)
Write-Host $Env:Path -ForegroundColor Cyan
Write-Host $(gcc --version) -ForegroundColor Magenta

Set-Item Env:LIBUSB_PTH -Value $LIBUSB_PTH
Set-Item Env:LIBUSB_INC_PTH -Value $LIBUSB_INC_PTH
Set-Item Env:LIBUSB_LIB_PTH -Value $LIBUSB_LIB_PTH
Set-Item Env:LIBUSB_DLL_PTH -Value $LIBUSB_DLL_PTH

Set-Item Env:PKG_CONFIG_PATH -Value $Env:LIBUSB_PTH

Set-Item -Path Env:Path -Value ($Env:LIBUSB_PTH + ";" + $Env:Path)
Set-Item -Path Env:Path -Value ($Env:LIBUSB_INC_PTH + ";" + $Env:Path)
Set-Item -Path Env:Path -Value ($Env:LIBUSB_LIB_PTH + ";" + $Env:Path)
Set-Item -Path Env:Path -Value ($Env:LIBUSB_DLL_PTH + ";" + $Env:Path)

# To be able to compile gousb, this flags is needed
Set-Item Env:CGO_CFLAGS -Value ("-I" +  $Env:LIBUSB_INC_PTH)
Write-Host ("CGO_CFLAGS = " + $Env:CGO_CFLAGS) -ForegroundColor Green
# For mingw-w64
Set-Item Env:CGO_LDFLAGS -Value ("-L" +  $Env:LIBUSB_LIB_PTH + " -lusb-1.0")
Write-Host ("CGO_LDFLAGS = " + $Env:CGO_LDFLAGS) -ForegroundColor Green

If(!(test-path "$LIBUSB_PTH/libusb-1.0.pc"))
{
    Copy-Item "./libusb-1.0.pc" -Destination $LIBUSB_PTH
}
Write-Host $("libusb package config : " + $(pkg-config --cflags  libusb-1.0)) `
-ForegroundColor Magenta

go get github.com/go-gl/gl/v4.1-core/gl
go get github.com/go-gl/glfw/v3.2/glfw
go get github.com/google/gousb