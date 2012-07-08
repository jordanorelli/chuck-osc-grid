class Poop
{
    OscBank bank;
    Monome monome;

    fun void init(string monome_prefix, int monome_recv_port, string monome_hostname, int monome_send_port) {
        monome.init(monome_prefix, monome_recv_port, monome_hostname, monome_send_port);
        OscBank.OscBank(8, 8, 5, 1, 55.0, 12) @=> bank;
        bank.setPatch("SinOsc");
        spork ~ listen();
    }

    fun void listen() {
        monome.e @=> MonomeKeyEvent e;
        while(true) {
            e => now;
            bank.setOp(e.x, e.y, e.v);
            monome.set(e.x, e.y, e.v);
        }
    }
}

Poop monome;
monome.init("/example", 34601, "localhost", 17102);

while(true) { 1::second => now; }
