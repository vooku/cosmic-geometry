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

void voronoi_f1f2_3d
(
    point P;
    output float f1,
                 f2;
    output point pos1,
                 pos2
)
{
    f1 = f2 = 1000;
    point thiscell = point (floor(xcomp(P)) + 0.5, floor(ycomp(P)) + 0.5, floor(zcomp(P)) + 0.5);
    uniform float i, j, k;

    for (i = -1; i <= 1; i += 1) {
        for (j = -1; j <= 1; j += 1) {
            for (k = -1; k <= 1; k += 1) {
                point testcell = thiscell + vector(i,j,k);
                vector offset = vector(cellnoise(testcell) + vector turbulence(P, 8) * 0.3);
                point pos = point(testcell + offset - 0.5);
                float dist = distance(pos, P);

              if (dist < f1) {
                f2 = f1;
                pos2 = pos1;
                f1 = dist;
                pos1 = pos;
              }
              else if (dist < f2) {
                f2 = dist;
                pos2 = pos;
              }
            }
        }
    }
}

surface voronoi
(
    float Ka = 1,
          Kd = 1,
          frequency = 5;
    color tileColor = color(0),
          gapColor = color(1),
          specularColor = color(1);
    string bakefile = "";
)
{
    normal Nn = faceforward(normalize(N), I);

    float f1, f2;
    point pos1, pos2;
    voronoi_f1f2_3d(P, f1, f2, pos1, pos2);

    f1 += noise(xcomp(P) * frequency, ycomp(P) * frequency) * 0.1 - 0.025;
    float c = step(0.05, f2-f1);
    Ci = mix(gapColor, tileColor, c) - 0.5 * turbulence(P, 32);

    if (bakefile != "")
      bake(bakefile, s, t, c);

    Oi = Os;
    Ci *= Ka * ambient() + Kd * diffuse(Nn);
    Ci *= Oi;
}