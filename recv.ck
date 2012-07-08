Math.pow(2, 1/12.0) => float toneStep;
ToneCalc.grid(8, 8, 5, 1, 55.0, 12.0) @=> float tones[][];
UgenGrid envelopes;
envelopes.init(8, 8);
for(0 => int x; x < envelopes.width(); x++) {
    for(0 => int y; y < envelopes.height(); y++) {
        ADSR e;
        e.set(3::ms, 100::ms, 0.5, 500::ms);
        e.keyOff();
        envelopes.set(x, y, e);
    }
}

UgenGrid root;
root.init(8, 8);
for(0 => int x; x < root.width(); x++) {
    for(0 => int y; y < root.height(); y++) {
        SinOsc s;
        tones[x][y] => s.freq;
        root.set(x, y, s);
    }
}

root.patch(envelopes);
envelopes.patch(dac);

Monome monome;
monome.init("/example", 34601, "localhost", 17102);

fun void monomeHandler() {
    monome.e @=> MonomeKeyEvent e;
    while(true) {
        e => now;
        monome.set(e.x, e.y, e.v);
        envelopes.get(e.x, e.y) $ ADSR @=> ADSR env;
        if(e.v == 0) {
            env.keyOff();
        } else {
            env.keyOn();
        }
    }
}

spork ~ monomeHandler();

while(true) { 1::second => now; }
