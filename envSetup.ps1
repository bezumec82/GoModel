Set-Item Env:GOROOT -Value ("h:\Go")
Write-Output $Env:GOROOT
Set-Item -Path Env:Path -Value ($Env:GOROOT + "\bin;" + $Env:Path)
Write-Output $Env:Path
# Set-Item -Path Env:Path -Value ($Env:Path + ";h:\MinGW\bin\")
# Write-Output $Env:Path
go version

# Usually I'm creating separate folder for all my golang projects
# For example 'd:/PROJECTS/GO'
# GOPATH = 'src' <- 'github.com' <- github owner <- project
Set-Item Env:GOPATH -Value ( Resolve-Path ${pwd}\..\..\..\.. )
Write-Output $Env:GOPATH
mkdir $Env:GOPATH\bin
Set-Item Env:GOBIN -Value ( Resolve-Path $Env:GOPATH\bin )
Write-Output $Env:GOBIN

#mingw-w64 4.8.5
# Set-Item Env:GCCPTH -Value "c:\\Program Files\\mingw-w64\\x86_64-4.8.5-posix-sjlj-rt_v4-rev0\\mingw64\\bin"
Set-Item Env:GCCPTH -Value "h:\mingw-w64\x86_64-4.8.5-posix-sjlj-rt_v4-rev0\mingw64\bin\"
ls $Env:GCCPTH
Set-Item -Path Env:Path -Value ($Env:GCCPTH + ";" + $Env:Path)
Write-Output $Env:Path
gcc --version

# To be able to compile gousb, this flags is needed
Set-Item Env:LIBUSB_PTH -Value "h:\Libraries\libusb-1.0.22"
Set-Item Env:LIBUSB_INC_PTH -Value ($Env:LIBUSB_PTH + "\include\libusb-1.0")
Set-Item Env:PKG_CONFIG_PATH -Value $Env:LIBUSB_PTH
pkg-config --cflags  libusb-1.0

Set-Item Env:LIBUSB_LIB_PTH -Value ($Env:LIBUSB_PTH + "\MinGW64\static")
Set-Item Env:LIBUSB_DLL_PTH -Value ($Env:LIBUSB_PTH + "\MinGW64\dll")

Set-Item -Path Env:Path -Value ( $Env:LIBUSB_PTH + ";" + $Env:Path )
Set-Item -Path Env:Path -Value ( $Env:LIBUSB_INC_PTH + ";" + $Env:Path )
Set-Item -Path Env:Path -Value ( $Env:LIBUSB_LIB_PTH + ";" + $Env:Path )
Set-Item -Path Env:Path -Value ( $Env:LIBUSB_DLL_PTH + ";" + $Env:Path )

Set-Item Env:CGO_CFLAGS -Value ("-I" +  $Env:LIBUSB_INC_PTH)
Write-Output $Env:CGO_CFLAGS
# For mingw-w64
Set-Item Env:CGO_LDFLAGS -Value ("-L" +  $Env:LIBUSB_LIB_PTH + " -lusb-1.0")
Write-Output $Env:CGO_LDFLAGS
go get github.com/go-gl/gl/v4.1-core/gl
go get github.com/go-gl/glfw/v3.2/glfw
go get github.com/google/gousb