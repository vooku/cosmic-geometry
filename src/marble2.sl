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
    float turbulence = 0;
    float lod = pow(2, 2 + txtscale);
    float originalLod = lod;
    while (lod >= 1) {
        //turbulence += noise(u * lod, v * lod);
        turbulence += noise(transform("object", P) * lod);
        lod /= 2;
    }
    turbulence /= log(originalLod, 2) + 1;

    float c =  (1 + sin((u + v + turbulence) * scale)) / 2;
    c += mix(c, step(c, 0.5), 0.5);
    c = clamp(c, 0, 1);

    Oi = Os;
    Ci = mix(c2, c1, c);    
    Ci *= Ka * ambient() + Kd * diffuse(Nn);
    Ci += specularColor * Ks * specular(Nn, -normalize(I), roughness);
    Ci *= Oi;
}