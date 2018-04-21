surface marble1
(
    float Ka = 1,
          Kd = 1,
          Ks = 1,
          roughness = 0.15,
          txtscale = 1;
    color specularColor = color(1);
)
{
    point PP = transform("shader", P) * txtscale;
    normal Nn = faceforward(normalize(N), I);
    float pixelsize = sqrt(area(PP));
    float twice = 2 * pixelsize;
    float turbulence = 0;
    float scale;
    
    for (scale = 1; scale > twice; scale /= 2)
        turbulence += scale * noise(PP/scale);

    if (scale > pixelsize) {
        float weight = (scale / pixelsize) - 1;
        weight = clamp(weight, 0, 1);
        turbulence += weight * scale * noise(PP/scale);
    }

    float csp = clamp(4 * turbulence -3, 0, 1);

    color c1 = color(1, 0.85, 0.65);
    color c2 = color(0.9, 0.52, 0.4);
    color c3 = color(1, 0.72, 0.82);
    color c4 = color(0.8, 0.52, 0.9);
    color c5 = color(0.69, 0.67, 1); 
    
    Oi = Os;
    Ci = color spline (csp, c5, c1, c2, c3, c2, c3, c2, c5, c2, c1, c5);
    Ci *= Ka * ambient() + Kd * diffuse(Nn);
    Ci += specularColor * Ks * specular(Nn, -normalize(I), roughness);
    Ci *= Oi;

}