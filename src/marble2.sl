float turbulence
(
    point P;
    float originalLod;
)
{
    float lod = originalLod;
    float turb = 0;
    while (lod >= 1) {
        turb += noise(P * lod);
        lod /= 2;
    }
    turb /= log(originalLod, 2) + 1;
    return turb;
}

surface marble2
(
    float Ka = 1,
          Kd = 1,
          Ks = 1,
          roughness = 0.15,
          txtscale = 1;
    color c1 = color(1),
          c2 = color(1),
          specularColor = color(1);
)
{
    normal Nn = faceforward(normalize(N), I);
    float scale = txtscale * 30;
    float turb = turbulence(transform("world", P), pow(2, 2 + txtscale));

    float c =  (1 + sin((u + v + turb) * scale)) / 2;
    c += mix(c, step(c, 0.5), 0.5);
    c = clamp(c, 0, 1);

    Oi = Os;
    Ci = mix(c2, c1, c);    
    Ci *= Ka * ambient() + Kd * diffuse(Nn);
    Ci += specularColor * Ks * specular(Nn, -normalize(I), roughness);
    Ci *= Oi;
}