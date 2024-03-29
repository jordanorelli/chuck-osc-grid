/*
Copyright (C) 2011 by Jordan Orelli

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
public class ToneCalc
{
    // generates a one-dimensional array of even-tempered frequency values.
    fun static float[] row(int size, int cellStep, float baseFreq,
                           float octaveSteps)
    {
        float tones[size];
        Math.pow(2, 1.0/ octaveSteps $ float) => float toneStep;
        for(0 => int i; i < size; i ++)
            baseFreq * Math.pow(toneStep, i * cellStep) => tones[i];

        return tones;
    }

    // generates a two-dimensional array of even-tempered frequency values.
    fun static float[][] grid(int width, int height, int columnStep,
                              int rowStep, float baseFreq, float octaveSteps)
    {
        float tones[width][height];
        Math.pow(2, 1.0/ octaveSteps $ float) => float toneStep;
        for(0 => int row; row < height; row++) {
            baseFreq * Math.pow(toneStep, row * rowStep) => float rowBase;
            for(0 => int col; col < width; col++) {
                rowBase * Math.pow(toneStep, col * columnStep)
                    => tones[col][row];
            }
        }
        return tones;
    }
}

