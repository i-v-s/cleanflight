import qbs
import "qbs/imports/Stm32f1Application.qbs" as Stm32f1Application


Stm32f1Application {
    property string targetFile  : "naze32f103"
    property string cmsisDir : "lib/main/CMSIS"
    //property string cmss
    property string linkerDir : "src/main/target"
    property string target: "NAZE"
    property string forkName: "cleanflight"
    property int flashSize: 128

    type: ["application", "hex","bin","size", "elf", "disassembly"]
    name: "Naze32 rev 6 Cleanflight"
    consoleApplication: true

    property stringList cppAppDefines : [
        'USE_STDPERIPH_DRIVER',
        'NAZE',
        '__FORKNAME__="' + forkName + '"',
        '__TARGET__="' + target + '"',
        "__REVISION__=0" //REVISION := $(shell git log -1 --format="%h")
    ]

    /*cpp.includePaths: [
        "src/main",
        "src/main/target/" + target

    ]*/

    Group {
        name : "Std periph"
        prefix : "lib/main/STM32F10x_StdPeriph_Driver/src/"
        files : "*.c"
    }

    /*Group {
        name : CMSIS
    }*/

    //property stringList cmsisSrc : [ cmsisDir + "/CM3/CoreSupport/core_cm3.c" ]
    property stringList targetSrc : [ "target/" + target + "/*.c"]

    Group {
        name : "System"
        prefix : "src/main/"
        files : [
            "build/build_config.c",
            "build/debug.c",
            "build/version.c",
            "config/config_streamer.c",
            "config/parameter_group.c",
            "config/config_eeprom.c",
            "common/encoding.c",
            "common/filter.c",
            "common/maths.c",
            "common/printf.c",
            "common/streambuf.c",
            "common/typeconversion.c",
            "common/crc.c",
            "common/pilot.c",
            "drivers/buf_writer.c",
            "drivers/dma.c",
            "drivers/serial.c",
            "drivers/system.c",
            "scheduler/scheduler.c",
            "io/serial.c",
            "io/statusindicator.c",
            "msp/msp.c",
            "msp/msp_serial.c",
            "msp/msp_server.c"
        ]
    }
    //.concat(cmsisSrc)
    //.concat(targetSrc)


    /*Group {
        name : "Flight control common sources"
        prefix: "src/main/"
        files: */
    property stringList fcCommonSrc : [
        "config/feature.c",
        "config/profile.c",
        "fc/boot.c",
        "fc/fc_debug.c",
        "fc/cleanflight_fc.c",
        "fc/fc_tasks.c",
        "fc/rate_profile.c",
        "fc/rc_adjustments.c",
        "fc/rc_controls.c",
        "fc/rc_curves.c",
        "fc/fc_serial.c",
        "fc/config.c",
        "fc/runtime_config.c",
        "fc/msp_server_fc.c",
        "flight/altitudehold.c",
        "flight/failsafe.c",
        "flight/pid.c",
        "flight/pid_luxfloat.c",
        "flight/pid_mwrewrite.c",
        "flight/pid_mw23.c",
        "flight/imu.c",
        "flight/mixer.c",
        "flight/servos.c",
        "drivers/bus_i2c_soft.c",
        "drivers/exti.c",
        "drivers/io.c",
        "drivers/rcc.c",
        "drivers/sound_beeper.c",
        "drivers/gyro_sync.c",
        "io/beeper.c",
        "io/gimbal.c",
        "io/servos.c",
        "io/motors.c",
        "io/serial_4way.c",
        "io/serial_4way_avrootloader.c",
        "io/serial_4way_stk500v2.c",
        "io/serial_cli.c",
        //"io/statusindicator.c",
        "rx/rx.c",
        "rx/pwm.c",
        "rx/msp.c",
        "rx/sbus.c",
        "rx/sumd.c",
        "rx/sumh.c",
        "rx/spektrum.c",
        "rx/xbus.c",
        "rx/ibus.c",
        "rx/srxl.c",
        "sensors/sensors.c",
        "sensors/acceleration.c",
        "sensors/battery.c",
        "sensors/voltage.c",
        "sensors/amperage.c",
        "sensors/boardalignment.c",
        "sensors/compass.c",
        "sensors/gyro.c",
        "sensors/initialisation.c"
    ]

    property stringList highendSrc : [
        "flight/gtune.c",
        "flight/navigation.c",
        "flight/gps_conversion.c",
        "common/colorconversion.c",
        "io/gps.c",
        "io/ledstrip.c",
        "io/display.c",
        "telemetry/telemetry.c",
        "telemetry/frsky.c",
        "telemetry/hott.c",
        "telemetry/smartport.c",
        "telemetry/ltm.c",
        "telemetry/mavlink.c",
        "telemetry/ibus.c",
        "sensors/sonar.c",
        "sensors/barometer.c",
        "blackbox/blackbox.c",
        "blackbox/blackbox_io.c"
    ]

    /*Group {
        name: "STM32F10x sources"
        prefix: "src/main/"
        files:*/
    property stringList stm32f10xSrc : [
        "drivers/adc.c",
        "drivers/adc_stm32f10x.c",
        "drivers/bus_i2c_stm32f10x.c",
        "drivers/gpio_stm32f10x.c",
        "drivers/light_led_stm32f10x.c",
        "drivers/serial_uart.c",
        "drivers/serial_uart_stm32f10x.c",
        "drivers/system_stm32f10x.c"
    ]

    Group {
        name: "Naze"
        prefix: "src/main/"
        files: [
            "startup/startup_stm32f10x_md_gcc.S",
            "drivers/accgyro_adxl345.c",
            "drivers/accgyro_bma280.c",
            "drivers/accgyro_l3g4200d.c",
            "drivers/accgyro_mma845x.c",
            "drivers/accgyro_mpu.c",
            "drivers/accgyro_mpu3050.c",
            "drivers/accgyro_mpu6050.c",
            "drivers/accgyro_mpu6500.c",
            "drivers/accgyro_spi_mpu6500.c",
            "drivers/barometer_bmp085.c",
            "drivers/barometer_ms5611.c",
            "drivers/barometer_bmp280.c",
            "drivers/bus_spi.c",
            "drivers/compass_hmc5883l.c",
            "drivers/display_ug2864hsweg01.h",
            "drivers/flash_m25p16.c",
            "drivers/inverter.c",
            "drivers/light_ws2811strip.c",
            "drivers/light_ws2811strip_stm32f10x.c",
            "drivers/sonar_hcsr04.c",
            "drivers/pwm_mapping.c",
            "drivers/pwm_output.c",
            "drivers/pwm_rx.c",
            "drivers/serial_softserial.c",
            "drivers/sound_beeper_stm32f10x.c",
            "drivers/timer.c",
            "drivers/timer_stm32f10x.c",
            "io/flashfs.c",
            "target/NAZE/hardware_revision.c"
        ]
        //.concat(systemSrc)
        .concat(fcCommonSrc)
        .concat(stm32f10xSrc)
        .concat(highendSrc)
    }
              /* $(HIGHEND_SRC)",
               $(FC_COMMON_SRC)",
               $(SYSTEM_SRC)*/
}
