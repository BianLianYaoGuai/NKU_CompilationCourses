// test hex and oct
int test_hexoct() {
    int a, b;
    a = 0xf0aC;
    b = 0XcBeF;
    return a + b + 075;
}

// test float
void test_float() {
    // decimal floating constant
    const float RADIUS = 5.5, PI = 03.141592653589793, EPS = 1e-6;
    float FACT = -.33E+5;
    // hexadecimal floating constant    
    const float PI_HEX = 0x1.921fb6p+1, HEX2 = 0X.AP-3;
}

// test annotation
void test_annotation() {
    int f, g, h;
    // */
    f = g/**//h;
    /*//*/ f = g % h;
    f = g //**/o
    + h;
    /* comment */ f = g * h */
}

// test terminal
void test_terminal() {
    const int arr[5]={0,1,2,3,4};
    int a = (arr[1] + 2) * 3 / 4 - 5 % 2;
    int b, c, d;
    while (a < 75) {
        b = 42;
        if (a <= 99) {
            c = b * 2;
            if (1 == 1) {
                a = c * 2;
                break;
            }
        }
    }
    d = -2;
    if (!((d * 1 / 2) > 0 || (a - b) >= 0) && (c + 3) % 2 != 0) {
        putint(d);
    }
}

// test scope
int k;
void test_scope() {
    k = 3389;
    if (k < 10000) {
        k = k + 1;
        int k = 112;
        k = k - 88;
    }
    putint(k);
}
