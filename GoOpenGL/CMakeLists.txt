cmake_minimum_required( VERSION 3.14 )

project( GoOpenGL )

if( WIN32 )
    execute_process (
    COMMAND powershell 
        "echo 'Building ${PROJECT_NAME}'
        cd ${CMAKE_CURRENT_SOURCE_DIR}
        $Env:GOPATH=\"h:/PROJECTS/GO\"
        $Env:PATH=\"h:\\Go\\bin;h:\\mingw-w64\\x86_64-4.8.5-posix-sjlj-rt_v4-rev0\\mingw64\\bin\"
        ls
        go build -o ../out/${PROJECT_NAME}.exe"
    )
endif()