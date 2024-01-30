<project xmlns="com.autoesl.autopilot.project" name="Virtual_ADC" top="Buffer_ADC" projectType="C/C++">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" clean="true" csimMode="0" lastCsimMode="0"/>
    </Simulation>
    <files xmlns="">
        <file name="../virtual_adc/buffer_adc.cpp" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
        <file name="../virtual_adc/buffer_adc.h" sc="0" tb="false" cflags="" csimflags="" blackbox="false"/>
        <file name="../../../virtual_adc/main.cpp" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="baseline" status="active"/>
    </solutions>
</project>

