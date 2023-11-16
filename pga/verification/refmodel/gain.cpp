#include <stdio.h>
#include <math.h>

extern "C" double calculateAmplitude(double Amplitude, int VCVGA, double VDD, double VSS) {
    // Calculate the linear gain factor from VCVGA in dB
    double gain = -1 + 3*VCVGA;

    double linearGain = pow(10.0, gain / 20.0);

    double vMax = (VDD-VSS) > 0.001 ? (VDD-VSS) : 0.001;

    // Multiply the Amplitude by the linear gain
    double AMPL_OUT = vMax*tanh(linearGain*(Amplitude)/vMax);

    return AMPL_OUT;
}