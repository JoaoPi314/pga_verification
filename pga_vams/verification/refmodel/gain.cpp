#include <stdio.h>
#include <math.h>
#include <stdint.h>

double min(double a, double b) {
    return (fabs(a) < fabs(b)) ? a : b;
}


extern "C" double calculateAmplitude(double Amplitude, uint8_t gain) {
    // Calculate the linear gain factor from gain in dB
    double gainDB = 40 - 0.25*(255 - gain);

    double linearGain = pow(10.0, gainDB / 20.0);

    double vMax = Amplitude < 0 ? -3 : 3;
    // Multiply the Amplitude by the linear gain
    double AMPL_OUT = min(linearGain*Amplitude + 1.5, vMax);

    return AMPL_OUT;
}