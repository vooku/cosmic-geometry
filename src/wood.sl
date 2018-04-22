surface wood
(
    float Ka = 1,
          Kd = 1,
          Ks = 0.9,
          varnish = 3,
          roughness = 0.15,
          txtscale = 10,
          logsize = 5,
          frequency = 0.8;
    color lighter = color(1),
          darker = color(1);
)
{
    normal Nn = faceforward(normalize(N), I);

    point C = (0, 0, 0);
    vector axis = (0, 0, 1);
    point Pp = transform("world", P);
    float t0 = axis . (Pp - C) / axis . axis;
    point Q = C + t0 * axis;

    float c = 0.5 * (1 + sin((distance(Pp, Q) + noise(xcomp(Pp) * frequency, ycomp(Pp) * frequency)) * txtscale));
    c += noise(Pp * frequency * 50);
    c /= 2;

    float Kss = Ks + smoothstep(0, 1, c) * varnish * Ks;
    Ci = mix(lighter, darker, c);

    Oi = Os;
    Ci *= Ka * ambient() + Kd * diffuse(Nn);
    Ci += Kss * specular(Nn, -normalize(I), roughness);
    Ci *= Oi;
}