import qbs

Product {
    name: "Kalman flight"

    // Целевой контроллер:
    property int stm32f    : 103
    property int flashSize : 128

    property string targetFile   : "naze32f103"

    // Папки библиотек
    property string cmsisDir     : "lib/main/CMSIS"
    property string stdPeriphDir : "lib/main/STM32F10x_StdPeriph_Driver"
    property string linkerDir    : "src/main/target/"

    property string target: "NAZE"
    property string forkName: "kalmanflight"

    type: ["application", "hex","bin","size", "elf", "disassembly"]
    consoleApplication: true
    Depends { name: "cpp" }

    cpp.commonCompilerFlags: [
        "-mthumb",
        "-mcpu=cortex-m3"
    ]

    cpp.linkerFlags: [
        "-mthumb",
        "-mcpu=cortex-m3"
    ]

    cpp.libraryPaths: [
        product.sourceDirectory + "/" + linkerDir
    ]

    cpp.defines: ["STM32F10X", "STM32F10X_MD"]

    cpp.includePaths: [
        cmsisDir + "/CM3/CoreSupport",
        cmsisDir + "/CM3/DeviceSupport/ST/STM32F10x",

        "src/main",
        "src/main/target/" + target,

        stdPeriphDir + "/inc",
        "lib/main/mavlink"
    ]

    Properties {
        condition: qbs.buildVariant === "debug"

        cpp.commonCompilerFlags: outer.concat([
            "-fverbose-asm",
            //"-save-temps=obj"
        ])
        cpp.debugInformation: true
        cpp.optimization: "none"

        cpp.linkerFlags: outer.concat([
            "-lc",
            "-lnosys",
            "-specs=nosys.specs"
        ])
    }

    Group {
        name : "Linker"
        fileTags: "linkerscript"
        prefix : linkerDir
        files : "stm32_flash_f" + stm32f + "_" + flashSize + "k.ld"
    }

    Group {
        name : "Sources"
        prefix : "src/main/"
        files : [
            "kalman/main.cpp",
        ]
    }

    Group {
        name : "System"
        prefix : "src/main/"
        files: [
            "startup/startup_stm32f10x_md_gcc.S",
            /*"drivers/adc.c",
            "drivers/adc_stm32f10x.c",
            "drivers/bus_i2c_stm32f10x.c",
            "drivers/gpio_stm32f10x.c",
            "drivers/light_led_stm32f10x.c",
            "drivers/serial_uart.c",
            "drivers/serial_uart_stm32f10x.c",
            "drivers/system_stm32f10x.c"*/
        ]
    }
    Group {
        name : "CMSIS"
        prefix : cmsisDir
        files : [
            "/CM3/CoreSupport/*.c",
            "/CM3/DeviceSupport/ST/STM32F10x/*.c"
        ]
    }
}
